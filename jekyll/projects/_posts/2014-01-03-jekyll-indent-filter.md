---

title: Jekyll Indentation Filter
date: 2014-01-03T23:20:00-08:00
excerpt: A Jekyll plugin to provide an indentation filter.

permalink: /projects/jekyll-indent-filter

section: Personal Projects
tags: [Jekyll, Ruby, MIT]

license: MIT

repository: https://github.com/itafroma/jekyll-indent_filter

---
This plugin provides a filter for indenting Liquid output. Based on the example
plugin described in [Mike Fulcher][1]’s blog post,
"[Better Indentation for Injected Jekyll Content][2]", this plugin solves the
`<pre>` and `<code>` tag caveat mentioned in the blog post and incorporates a
few code style changes and optimizations.

## Installation

This plugin is provided as a gem:

```sh
gem install jekyll-itafroma-indent_filter
```

Once the gem is installed, include it in your Jekyll site's configuration:

```yaml
gems: ['jekyll/itafroma/indent_filter']
```

## Usage

Specify the number of spaces you’d like the output to be by using the `indent`
filter:

```liquid
{% raw %}{{ content | indent: 20 }}{% endraw %}
<!-- content will be indented 20 spaces -->
```

## Acknowledgements

This plugin is inspired the example provided in Mike Fulcher’s blog post,
"Better Indentation for Injected Jekyll Content".

The `<pre>` and `<code>` indentation solution was inspired by [kerotaa][3]'s
[remove-empty-lines-html.rb][4] plugin.

## Copyright and license

This plugin is copyright © 2013 Mark Trapp. All rights reserved. It is made
available via the MIT license. A copy of the license can be found in the
`LICENSE` file.

## Related links

* [RubyGems project page][5]

[1]: http://drawingablank.me "Muke Fulcher’s website"
[2]: http://drawingablank.me/blog/indentation-for-injected-jekyll-content.html "Better Indentation for Injected Jekyll Content"
[3]: http://kerotaa.hateblo.jp "kerotaa’s website"
[4]: https://gist.github.com/kerotaa/5788650 "kerotaa’s remove-empty-lines-html.rb"
[5]: https://rubygems.org/gems/jekyll-itafroma-indent_filter "RubyGems project page"
