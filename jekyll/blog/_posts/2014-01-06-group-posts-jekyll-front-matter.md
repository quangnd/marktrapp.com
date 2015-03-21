---

title: Grouping posts by a front-matter key in Jekyll
date: 2014-01-06T21:05:00-08:00
excerpt: In Jekyll, you can group posts by a custom front-matter key using a simple generator plugin.

section: Programming
tags: [Ruby, Jekyll]

license: none

---
{% raw %}
Within [Jekyll][1], there are two built-in "grouping" variables for posts: `site.categories` and `site.tags`. But what if you want to group your posts on another [front-matter][2] key? While Jekyll allows you to add any custom key you want to your post front-matter, it doesn’t automatically group your posts by those custom keys. I ran into this issue on this site: I wanted to group my blog posts by topic, but I was already using categories and tags for other things.

To solve this problem, I looked at how Jekyll creates `site.categories` and `site.tags`. You can find the [code populating these variables][3] in `lib/jekyll/site.rb`:

```ruby
def site_payload
  {"jekyll" => { "version" => Jekyll::VERSION },
   "site" => self.config.merge({
      "time"       => self.time,
      "posts"      => self.posts.sort { |a, b| b <=> a },
      "pages"      => self.pages,
      "html_pages" => self.pages.reject { |page| !page.html? },
      "categories" => post_attr_hash('categories'),
      "tags"       => post_attr_hash('tags'),
      "data"       => site_data})}
end
```

So they’re hard-coded, which means there’s not going to be a way to group custom front-matter keys without using a generator plugin (sorry, [GitHub Pages][4] users). I could also see that both `categories` and `tags` are populated using the [`post_attr_hash`][5] method:

```ruby
def post_attr_hash(post_attr)
  # Build a hash map based on the specified post attribute ( post attr =>
  # array of posts ) then sort each array in reverse order.
  hash = Hash.new { |hsh, key| hsh[key] = Array.new }
  self.posts.each { |p| p.send(post_attr.to_sym).each { |t| hash[t] << p } }
  hash.values.map { |sortme| sortme.sort! { |a, b| b <=> a } }
  hash
end
```

This is pretty straightforward. `post_attr_hash` takes the key to group as a parameter and then:

1. A hash is created for `categories` and `tags`. Each key in the hash is associated with a new array.
2. For each post on the site, Jekyll checks the contents of `categories` and `tags` and creates a new key for each value if it doesn`t exist.
3. It then adds that post to the hash under the keys it just created.
4. Once it’s done filling the hash, it sorts the hash in reverse chronological order.

What if I created a generator plugin that simply called `post_attr_hash` with my custom front-matter key? Something like:

```ruby
module Jekyll
  class SectionGenerator < Jekyll::Generator
    def generate(site)
     site.config['sections'] = site.post_attr_hash('section')
    end
  end
end
```

Unfortunately, Jekyll will throw a `NoMethodError` for "section": this is due to the following line in `post_attr_hash`:

```ruby
self.posts.each { |p| p.send(post_attr.to_sym).each { |t| hash[t] << p } }
```

Here, Jekyll is looking for the method named the same thing as the parameter (`p.send(pos_attr.to_sym)`), and since "section" doesn’t exist in the `Post` class, it fails. However, there is an alternative to using `send` to retrieeve the contents of the front-matter key: the `Post` class has a `data` member variable, which in turn has a `fetch` method that does largely the same thing.

To use it, I needed to define my own `hash` method and modify the original plugin to something like:

```ruby
module Jekyll
  class SectionGenerator < Jekyll::Generator
    SECTION_KEY = 'section'
    SECTION_KEY_PLURAL = 'sections'

    def generate(site)
      site.config['sections'] = post_key_hash(site, 'section')
    end

    ##
    # Generates a hash using a key from a post's front-matter.
    #
    def post_key_hash(site, post_key)
      hash = Hash.new { |hsh, key| hsh[key] = Array.new }
      site.posts.each { |p| p.data.fetch(post_key).each { |t| hash[t] << p } }
      hash.values.map { |sortme| sortme.sort! { |a, b| b <=> a } }
      hash
    end
  end
end
```

This works pretty well, but has two major caveats:

1. every single post must have a `section` key; if not, Jekyll will fail with a `KeyError`.
2. `section` must be an array. I wanted section to only accept a string.

I hardened against these by checking for the key before adding a post to the hash and removing the `each` block:

```ruby
module Jekyll
  class SectionGenerator < Jekyll::Generator
    def generate(site)
      site.config['sections'] = post_key_hash(site, 'section')
    end

    ##
    # Generates a hash using a key from a post's front-matter.
    #
    def post_key_hash(site, post_key)
      hash = Hash.new { |hsh, key| hsh[key] = Array.new }
      site.posts.each do |p|
        # Skip post if it doesn't have the correct key
        next unless p.data.has_key? post_key

        # Load the value for the key
        t = p.data.fetch(post_key)

        # Add the post to the hash
        hash[t] << p
      end

      # Sort and return the hash
      hash.values.map { |sortme| sortme.sort! { |a, b| b <=> a } }
      hash
    end
  end
end
```

The above will work great as is, but I wanted to incoporate an additional optional feature: the ability to exclude certain sections from the hash using the site’s configuration. This was easily done by adding a new `exclude` parameter to the method:

```ruby
module Jekyll
  class SectionGenerator < Jekyll::Generator
    def generate(site)
      if site.config['section'] && site.config['section']['exclude']
        exclude = site.config['section']['exclude']
      else
        exclude = []
      end
      site.config['sections'] = post_key_hash(site, 'section', exclude)
    end

    ##
    # Generates a hash using a key from a post's front-matter.
    #
    def post_key_hash(site, post_key, exclude)
      # Build a hash map based on the specified post attribute ( post attr =>
      # array of posts ) then sort each array in reverse order.
      hash = Hash.new { |hsh, key| hsh[key] = Array.new }
      site.posts.each do |p|
        # Skip post if it doesn't have the correct key
        next unless p.data.has_key? post_key

        # Load the value for the key and check to see if it should be excluded
        t = p.data.fetch(post_key)
        next if exclude.include? t

        # Add the post to the hash
        hash[t] << p
      end

      # Sort the hash
      hash.values.map { |sortme| sortme.sort! { |a, b| b <=> a } }
      hash
    end
  end
end
```

Now, if I add the following to `_config.yml`:

```yaml
section:
    exclude: ['Philosophy']
```

Any post tagged with `section: Philosophy` won’t appear in `site.sections`.
{% endraw %}

## Plugin

I created a general-purpose plugin that allows posts to be grouped on any front-matter key, available as a gem for easy inclusion in an existing Jekyll website. You can find more information on [its project page][6].

[1]: http://jekyllrb.com "Jekyll website"
[2]: http://jekyllrb.com/docs/frontmatter/ "Jekyll documentation on front-matter"
[3]: https://github.com/jekyll/jekyll/blob/92064134d67eb17392a45e4fc82d83423a4b8ff4/lib/jekyll/site.rb#L309 "site_payload within site.rb"
[4]: http://pages.github.com "GitHub Pages website"
[5]: https://github.com/jekyll/jekyll/blob/92064134d67eb17392a45e4fc82d83423a4b8ff4/lib/jekyll/site.rb#L279 "post_attr_hash within site.rb"
[6]: https://marktrapp.com/projects/jekyll-post-groups/ "Jekyll Post Group Generator project page"
