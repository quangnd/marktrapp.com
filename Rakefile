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
end
