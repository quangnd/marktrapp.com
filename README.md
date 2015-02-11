# marktrapp.com source

This repository contains the code for generating [marktrapp.com][1]. The purpose behind providing the website source is threefold:

* Make it relatively easy to submit fixes or changes to those that want to
* Maintain some amount of transparency about what goes into the website
* Act as an example for anyone who wants to use a static site generator

## System requirements

* Ruby 2.0.0 or higher
* [Bundler][2]
* [RedCarpet][3] 3.1.2 or later
* [Jekyll][4] 2.0.0 or later
* [Rake][5]
* [Node Package Manager (NPM)][6]

RedCarpet, Jekyll, and Rake have their own requirements and dependencies. If you follow the installation instructions below, those dependencies will be resolved automatically.

## Installation

1. Do whatever voodoo magic you want to do to get a working Ruby 2.0.0 (or higher) environment.
2. Install Bundler: `gem install bundler`.
3. Clone this repository: `git clone git@github.com:/itafroma/marktrapp.com`.
4. Run `bundle install` inside the cloned repository.
5. Run `bundle exec rake install` inside the cloned repository.
6. Run `bundle exec rake build` inside the cloned repository.

The generated site will be contained in the `_sites` directory.

## Licenses and usage

Where applicable, all files are copyright © 2013–2015 Mark Trapp.

Files within this repository are licensed on an individual basis. Note that there are automatic limitations to copyright (called "fair use" or "fair dealing")—including, but not limited to, excerpting, commentary, and personal reproduction—that do not require a license.

If an automatic license is granted for a specific file, the license the file uses is specified in its [front-matter][7] under the `license:` key or in its opening comment block. The full text of the licenses used can be found in the `licenses` directory.

Some files (e.g., the files that appear in the `_posts` directory) are not granted an automatic license, and and for those files, all rights are reserved (again, fair use is an automatic limitation to those rights). These files are indicated by having a `license: none` entry in their front-matter. With these files, if there's a use that falls outside the bounds of fair use, [contact me][8].

[1]: http://marktrapp.com "Mark Trapp’s website"
[2]: http://bundler.io "Bundler website"
[3]: https://github.com/vmg/redcarpet "RedCarpet repository"
[4]: https://github.com/jekyll/jekyll "Jekyll repository"
[5]: http://rake.rubyforge.org "RAKE - Ruby Make"
[6]: http://npmjs.org "NPM website"
[7]: http://jekyllrb.com/docs/frontmatter/ "Jekyll: Front-matter"
[8]: http://marktrapp.com/contact "Contact Mark Trapp"
