#
# Build script for MarkTrapp.com
#
# Author:: Mark Trapp
# Copyright: Copyright (c) 2013 Mark Trapp
# License:: MIT

npm_bin = `npm bin`.chomp

desc 'Install the necessary dependencies for building the website.'
task :install do |t|
  sh 'npm install'
  sh "#{npm_bin}/bower install"
end

desc 'Regenerate the website files and place them into _site.'
task :build do |t|
  target = '_site'
  prep = '_prep'

  rm_rf target
  sh 'bundle exec jekyll build'
  mkdir_p ["#{target}/assets/css", "#{target}/assets/images", prep]

  lessc = "#{npm_bin}/lessc --no-color"

  # group-css-media-queries requires uncompressed CSS, so run lessc again after
  #   group-css-media-queries to compress it.
  sh "#{lessc} assets/less/main.less > #{prep}/main.css"
  sh "#{npm_bin}/group-css-media-queries #{prep}/main.css #{prep}/main.css"
  sh "#{lessc} --compress #{prep}/main.css > #{target}/assets/css/main.css"

  cp_r 'assets/images', "#{target}/assets"
  rm_rf prep
end

desc 'Replace "lazy" Markdown references with proper versions'
task :refs do |t|
  FileList.new('jekyll/**/*.md').each do |path|
    File.open(path, 'r+') do |file|
      contents = file.read

      # Search file contents for Markdown references containing asterisks
      #  instead of numbers and replace them with numbers in the correct order.
      #  See http://brettterpstra.com/2013/10/19/lazy-markdown-reference-links/
      #  Credit to Glenn Fleishman and Brett Terpstra for the idea and
      #  implementation.
      counter = 0
      while contents =~ /(\[[^\]]+\]\s*\[)\*(\].*?^\[)\*\]\:/m
        contents.sub!(/(\[[^\]]+\]\s*\[)\*(\].*?^\[)\*\]\:/m) do
          counter += 1
          Regexp.last_match[1] + counter.to_s + Regexp.last_match[2] + counter.to_s + ']:'
        end
      end

      file.pos = 0
      file.print contents
      file.truncate(file.pos)
    end
  end
end
