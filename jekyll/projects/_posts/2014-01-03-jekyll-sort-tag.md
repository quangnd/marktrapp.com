---

title: Jekyll Sort Tag
date: 2014-01-03T23:45:00-08:00
excerpt: A Jekyll plugin to provide a sort tag.

permalink: /projects/jekyll-sort-tag

tags: [Jekyll, Ruby, MIT]

license: MIT

layout: project

repository: https://github.com/itafroma/jekyll-sort_tag

---
This is a really simple plugin for Jekyll that provides a
`{% raw %}{% sort %}{% endraw %}` Liquid tag to compliment Liquid's built-in
`sort` filter.

## Installation

This plugin is provided as a gem:

```sh
gem install jekyll-itafroma-sort_tag
```

Once the gem is installed, include it in your Jekyll site's configuration:

```yaml
gems: ['jekyll/itafroma/sort_tag']
```

## Usage

Wrap the output you’d like to sort with the tag:

```liquid
{% raw %}{% sort %}
Barbara
Alice
Christine
{% endsort %}{% endraw %}
```

## Copyright and license

This plugin is copyright © 2013 Mark Trapp. All rights reserved. It is made
available via the MIT license. A copy of the license can be found in the
`LICENSE` file.

## Related links

* [RubyGems project page][1]

[1]: https://rubygems.org/gems/jekyll-itafroma-sort_tag "RubyGems project page"
