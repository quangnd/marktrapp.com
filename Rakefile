#
# Build script for MarkTrapp.com
#
# Author:: Mark Trapp
# Copyright: Copyright (c) 2013 Mark Trapp
# License:: MIT

desc "Install the necessary dependencies for building the website."
task :install do |t|
  sh "npm install"
  sh "./node_modules/.bin/bower install"
end

desc "Regenerate the website files and place them into _site."
task :build do |t|
  target = "_site"
  prep = "_prep"

  rm_rf target
  sh "bundle exec jekyll build"
  mkdir_p ["#{target}/assets/css", "#{target}/assets/images", prep]

  # group-css-media-queries requires uncompressed CSS, so run lessc again after
  #   group-css-media-queries to compress it.
  sh "./node_modules/.bin/lessc --no-color assets/less/main.less > #{prep}/main.css"
  sh "./node_modules/.bin/group-css-media-queries #{prep}/main.css #{prep}/main.css"
  sh "./node_modules/.bin/lessc --no-color --compress #{prep}/main.css > #{target}/assets/css/main.css"

  cp_r "assets/images", "#{target}/assets"
  rm_rf prep
end
