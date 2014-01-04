---

title: Jekyll Newline Collapse
date: 2014-01-03T22:20:00-08:00
excerpt: A Jekyll plugin to strip extraneous whitespace.

permalink: /projects/jekyll-collapse_newlines

tags: [Jekyll, Ruby, MIT]

license: MIT

layout: post

repository: https://github.com/itafroma/jekyll-collapse_newlines

---
This plugin removes extra newlines from rendered Jekyll markup. Based on
[kerotaa][1]'s original [remove-empty-lines-html.rb][2] plugin, this version
strips newlines from non-HTML files and incorporates a few coding style changes.

## Installation

This plugin is provided as a gem:

```sh
gem install jekyll-itafroma-collapse_newlines
```

Once the gem is installed, include it in your Jekyll site's configuration:

```yaml
gems: ['jekyll/itafroma/collapse_newlines']
```

## Acknowledgements

This plugin is a direct derivative work of kerotaa’s plugin, which is used with
permission under the terms of the MIT license. The original plugin is copyright
© 2012 kerotaa. The full text of the permission notice required for the MIT
license can be found in the source code.

## Copyright and license

This plugin in its derivative form is copyright © 2013 Mark Trapp. All
rights reserved. It is made available via the MIT license. A copy of the license
can be found in the `LICENSE` file.

## Related links

* [RubyGems project page][3]

[1]: http://kerotaa.hateblo.jp "kerotaa’s website"
[2]: https://gist.github.com/kerotaa/5788650 "kerotaa’s remove-empty-lines-html.rb"
[3]: https://rubygems.org/gems/jekyll-itafroma-collapse_newlines "RubyGems project page"
