#
# Adds a site.sections variable.
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
        # Hash algorithm taken from Jekyl::Site::post_attr_hash
        hash = Hash.new { |hsh, key| hsh[key] = Array.new }
        site.posts.each do |post|
          if post.data.has_key? SECTION_KEY
            section = post.data.fetch(SECTION_KEY)
            unless site.config['section']['exclude'].include? section
              hash[section] << post
            end
          end
        end
        hash.values.map { |sortme| sortme.sort! { |a, b| b <=> a } }

       site.config[SECTION_KEY_PLURAL] = hash.sort
      end
    end
  end
end
