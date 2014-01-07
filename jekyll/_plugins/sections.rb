#
# Adds a site.sections variable.
#
# See http://marktrapp.com/blog/2014/01/06/group-posts-jekyll-front-matter/
#
# Author:: Mark Trapp
# Copyright: Copyright (c) 2014 Mark Trapp
# License:: MIT

module Jekyll
  module Itafroma
    class SectionGenerator < Jekyll::Generator
      SECTION_KEY = 'section'
      SECTION_KEY_PLURAL = 'sections'

      def generate(site)
        if site.config[SECTION_KEY] && site.config[SECTION_KEY]['exclude']
          exclude = site.config[SECTION_KEY]['exclude']
        else
          exclude = []
        end
        site.config[SECTION_KEY_PLURAL] = post_key_hash(site, SECTION_KEY, exclude)
      end

      ##
      # Generates a hash using a key from a post's front matter.
      #
      def post_key_hash(site, post_key, exclude)
        # Build a hash map based on the specified post attribute ( post attr =>
        # array of posts ) then sort each array in reverse order.
        hash = Hash.new { |hsh, key| hsh[key] = Array.new }
        site.posts.each do |p|
          # Skip post if it doesn't have the correct key
          next unless p.data.has_key? post_key

          # Load the value for the key and check to see if it should be excluded
          t = p.data.fetch(post_key)
          next if exclude.include? t

          # Add the post to the hash
          hash[t] << p
        end

        # Sort the hash
        hash.values.map { |sortme| sortme.sort! { |a, b| b <=> a } }
        hash
      end
    end
  end
end
