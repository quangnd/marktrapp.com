# Add support for additional PHP Markdown Extra extensions in Redcarpet
#
# Many of PHP Markdown Extra's extensions are already extant in Redcarpet, but
# there are some gaps. This plugin aims to fill those gaps.
#
# See http://michelf.ca/projects/php-markdown/extra/
#
# Currently only supports the abbreviation syntax.
#
# Author:: Mark Trapp
# Copyright: Copyright (c) 2014 Mark Trapp
# License:: MIT
# Acknowledgements:: Michel Fortin for the PHP Markdown Extra library and the
#   regexp used therein.
#

module Jekyll
  module Converters
    class Markdown::ItafromaRedcarpetExtra < Markdown::RedcarpetParser
      def convert(content)
        parse_abbreviations!(content)
        super
      end

      # Parse abbreviations.
      # Syntax: http://michelf.ca/projects/php-markdown/extra/#abbr
      def parse_abbreviations!(content)
        abbreviations = {}
        content.gsub!(/\*\[(.+?)\][ ]?:(.*)/) do |s|
          abbreviations[Regexp.last_match[1]] = Regexp.last_match[2]
          ''
        end
        sub = @redcarpet_extensions[:abbr_first_only] ? 'sub!' : 'gsub!'
        abbreviations.each do |abbr, description|
          description = CGI.escapeHTML(description.strip)
          content.send(sub, /(?<![\w\x1A])(?:#{abbr})(?![\w\x1A])/) do |s|
            "<abbr title=\"#{description}\">#{abbr}</abbr>"
          end
        end
      end
    end
  end
end
