---

title: Ending work on Jekyll Archive Generator
date: 2015-01-15T02:35:00-07:00
excerpt: Due to the existence of an official archive plugin for Jekyll, development on JAG is coming to an end.

section: Programming
tags: [Ruby, Jekyll, Jekyll Archive Generator]

license: none

---

A little over a year ago, I decided to replace my aging website—built on Drupal 6—with [Jekyll][1]. Out of the box, Jekyll had almost everything I needed, but was missing some key components to facilitate a seamless transition. The most glaring hole was a lack of support for "URL hacking": the idea that if a blog post had a URL of, say, `marktrapp.com/2015/01/15/foo`, you could go to `marktrapp.com/2015/01` and get an archive of all the blog posts created in January 2015. This is a common feature of CMSes, but with Jekyll, going to that page will result in a page not found.

After some searching, the best I found were a [couple of Gists being passed around][2] that provided basic support for it. They were a great starting point, but I wanted something more robust that I could configure easily to match my old website. After a few days of learning Jekyll plugin development (and brushing up on my basic Ruby knowledge), I created [Jekyll Archive Generator][3] (JAG).

I pushed it to GitHub and RubyGems and didn't think anything of it: it did what I needed, and since it seemed like such an obvious omission to be overlooked, maybe I was the only one using Jekyll that wanted it. After a few weeks, however, people found it, and were providing bug reports and feature suggestions. I took care of some of the low-hanging fruit, but I put JAG on the back-burner as life got in the way.

For the new year, I decided I was going to implement some of the "nice to have" features. After a few days of implementing various changes and updates, I took a look at [Jekyll's GitHub profile][4] and, lo-and-behold, I found [Jekyll Archives][5]. Over the summer, the people on the Jekyll team actually created a plugin to do what JAG did! Whoops.

This is all to say that it doesn't make much sense to continue to actively develop JAG anymore. If you were one of the people using it, you should probably switch over to Jekyll Archives, which does ~95% of what JAG does, when you get the chance. 

However, it seemed like such a waste to stop halfway through the changes I was working on, so I have created one final release of JAG, implementing some long-time feature requests:

* You can now create multiple archives, each with their own, independent path using variables similar to Jekyll's permalink variables.
* Titles can now be fully tokenized with various date parts using the same variables available to archive paths
* The exclusion filter (`exclude`) has been expanded to allow exact matching on any front matter key, not just categories.
* A new inclusion filter (`include`) has been added that acts as a whitelist.

These features required a significant change to the configuration schema, so be sure to check out the new options on the [project page][3].

You can download the source for the [latest release on GitHub][6] or [install it via RubyGems][7].

Thanks to everyone who checked it out, provided feedback, and bug reports: it was a great learning experience.

[1]: http://jekyllrb.com "Jekyll project page"
[2]: https://github.com/itafroma/jekyll-archive#acknowledgments "Precursor Gists for Jekyll archive functionality"
[3]: https://marktrapp.com/projects/jekyll-archive/ "Jekyll Archive Generator project page"
[4]: https://github.com/jekyll "Jekyll's GitHub profile"
[5]: https://github.com/jekyll/jekyll-archives "Jekyll Archives project page"
[6]: https://github.com/itafroma/jekyll-archive/releases/tag/0.4.2 "Jekyll Archive Generator 0.4.2 on GitHub"
[7]: https://rubygems.org/gems/jekyll-itafroma-archive "Jekyll Archive Generator on RubyGems"
