# Add an array intersect filter for Liquid
#
# Author:: Mark Trapp
# Copyright: Copyright (c) 2014 Mark Trapp
# License:: MIT

module Jekyll
  module Itafroma
    module IntersectFilter
      def intersect(array_left, array_right)
        array_left & array_right
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::Itafroma::IntersectFilter)
