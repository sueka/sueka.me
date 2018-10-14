require 'contracts'

module SuekaDotMe
  module Jekyll
    module SelectFilter
      include Contracts::Core
      include Contracts::Builtin

      Contract ArrayOf[::Jekyll::Document], String, String => ArrayOf[::Jekyll::Document]
      def select(xs, attr_name, replacement)
        xs.select { |x| (x.data[attr_name] || x.send(attr_name.to_sym)) == replacement }
      end
    end
  end
end

Liquid::Template.register_filter(SuekaDotMe::Jekyll::SelectFilter)
