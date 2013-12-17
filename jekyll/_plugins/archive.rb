#
# Generates archive pages for year, month, and day.
#
# An archive listing for each year, month, and day there's a post will be
# created.
#
# Configuration options:
#   archive:
#       layout: archive
#       path: /blog
#       title: Blog Archive - :date
#       exclude: ['projects']
# - layout: the name of the layout to use for the archive pages.
# - path: the path where the archive should be generated.
# - title: the title for the archive pages; it has one token, :date, that will
#   be replaced with a pretty version of the date.
# - exclude: an array of categories to exclude from the archive.
#
# Author:: Mark Trapp
# Copyright: Copyright (c) 2013 Mark Trapp
# License:: MIT
# Acknowledgements:: Inspired by the work done by nlindley and ilkka on Github:
#     https://gist.github.com/nlindley/6409459
#     https://gist.github.com/nlindley/6409441
#     https://gist.github.com/ilkka/707020
#     https://gist.github.com/ilkka/707909

module Jekyll
  ##
  # Represents an archive listing page.

  class ArchivePage < Page
    def initialize(site, base, pattern, posts)
      @site = site
      @base = base
      @dir = posts.first.date.strftime(pattern)
      @name = 'index.html'

      process(@name)

      layout = site.config['archive']['layout'] || 'archive'
      read_yaml(File.join(base, '_layouts'), "#{layout}.html")

      data['posts'] = posts
      data['date'] = {
        'value' => posts.first.date,
        'pattern' => pattern,
      }
    end

    def url
      base = site.config['archive']['path'] || '/'
      File.join(base, @dir, 'index.html')
    end

    def to_liquid
      data.deep_merge('url' => url, 'content' => content)
    end
  end

  ##
  # Generator for archive listing pages.

  class ArchiveGenerator < Generator
    safe true

    def generate(site)
      layout = site.config['archive']['layout'] || 'archive'
      if site.layouts.key? layout
        exclude_categories = site.config['archive']['exclude'] || []
        posts = site.posts.select do |post|
          (post.categories & exclude_categories).empty?
        end
        site.pages += generate_archive_pages(site, posts, '%Y/%m/%d')
        site.pages += generate_archive_pages(site, posts, '%Y/%m')
        site.pages += generate_archive_pages(site, posts, '%Y')
      end
    end

    private

    def generate_archive_pages(site, posts, pattern)
      pages = []
      collate(posts, pattern).each do |_, collated_posts|
        pages << ArchivePage.new(site, site.source, pattern, collated_posts)
      end
      pages
    end

    def collate(posts, pattern)
      collated = {}
      posts.each do |post|
        key = post.data['date'].strftime(pattern)
        collated[key] ||= []
        collated[key] << post
      end
      collated
    end
  end
end
