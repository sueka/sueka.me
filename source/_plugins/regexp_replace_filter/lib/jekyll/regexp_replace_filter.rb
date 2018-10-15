require 'contracts'

module SuekaDotMe
  module Jekyll
    # :nodoc:
    module RegexpReplaceFilter
      include Contracts::Core
      include Contracts::Builtin

      Contract String, String, String => String
      def regexp_replace(string, pattern, replacement)
        pattern = /#{ pattern }/

        string.gsub pattern, replacement
      end
    end
  end
end

Liquid::Template.register_filter(SuekaDotMe::Jekyll::RegexpReplaceFilter)
