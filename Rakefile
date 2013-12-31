#
# Build script for MarkTrapp.com
#
# Author:: Mark Trapp
# Copyright: Copyright (c) 2013 Mark Trapp
# License:: MIT

task :install do |t|
  sh "npm install"
  sh "./node_modules/.bin/bower install"
end

task :build do |t|
  sh "rm -rf ./_site"
  sh "bundle exec jekyll build"
  sh "mkdir -p ./_site/assets/css ./_site/assets/images ./_site/assets/fonts ./_prep"

  # group-css-media-queries requires uncompressed CSS, so run lessc again after
  #   group-css-media-queries to compress it.
  sh "./node_modules/.bin/lessc --no-color ./assets/less/main.less > ./_prep/main.css"
  sh "./node_modules/.bin/group-css-media-queries ./_prep/main.css ./_prep/main.css"
  sh "./node_modules/.bin/lessc --no-color --compress ./_prep/main.css > ./_site/assets/css/main.css"

  sh "cp ./assets/images/* ./_site/assets/images"
  sh "rm -rf ./_prep"
end
