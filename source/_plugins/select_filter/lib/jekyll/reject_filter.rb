require 'contracts'

module SuekaDotMe
  module Jekyll
    # :nodoc:
    module RejectFilter
      include Contracts::Core
      include Contracts::Builtin

      Contract ArrayOf[::Jekyll::Document], String, String => ArrayOf[::Jekyll::Document]
      def reject(xs, attr_name, replacement)
        xs.reject { |x| (x.data[attr_name] || x.send(attr_name.to_sym)) == replacement }
      end
    end
  end
end

Liquid::Template.register_filter(SuekaDotMe::Jekyll::RejectFilter)
