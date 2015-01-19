#
# Build script for MarkTrapp.com
#
# Author:: Mark Trapp
# Copyright: Copyright (c) 2013–2015 Mark Trapp
# License:: MIT

npm_bin = `npm bin`.chomp
prep = '_prep'
target = '_site'

desc 'Install the necessary dependencies for building the website.'
task :install do |t|
  sh 'npm install'
  sh "#{npm_bin}/bower install"
end

desc 'Prepare the website assets.'
task :prepare => :clean do
  mkdir_p ["#{prep}/css", "#{prep}/images", "#{prep}/js"]

  lessc = "#{npm_bin}/lessc --no-color"

  # group-css-media-queries requires uncompressed CSS, so run lessc again after
  #   group-css-media-queries to compress it.
  css_file = "#{prep}/css/main.css"
  sh "#{lessc} assets/less/main.less > #{css_file}.pre"
  sh "#{npm_bin}/group-css-media-queries #{css_file}.pre #{css_file}.pre"
  sh "#{lessc} --compress #{css_file}.pre > #{css_file}"
  rm "#{css_file}.pre"

  js = [
    'assets/js/wormtrails.js'
  ].join(' ')
  sh "#{npm_bin}/uglifyjs #{js} -o #{prep}/js/wormtrails.js -c -m"

  cp_r 'assets/images', prep
end

desc 'Regenerate the website files and place them into _site.'
task :build => :prepare do
  sh 'bundle exec jekyll build --trace'
  cp_r "#{prep}/.", "#{target}/assets"
end

desc 'Regenerate the website files (with drafts) and place them into _site.'
task :build_drafts => :prepare do
  sh 'bundle exec jekyll build --trace --drafts'
  cp_r "#{prep}/.", "#{target}/assets"
end

desc 'Clean up prepared and built files.'
task :clean do
  rm_rf [prep, target]
end

desc 'Replace "lazy" Markdown references with proper versions'
task :refs do |t|
  FileList.new('jekyll/**/*.md').each do |path|
    File.open(path, 'r+:utf-8') do |file|
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

desc 'Deploy website to S3.'
task :deploy do |t|
  sh 'bundle exec s3_website push'
end

