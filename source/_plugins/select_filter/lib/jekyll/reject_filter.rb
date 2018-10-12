module SuekaDotMe
  module Jekyll
    module RejectFilter
      def reject(xs, attr_name, replacement)
        xs.reject { |x| x.data[attr_name] == replacement }
      end
    end
  end
end

Liquid::Template.register_filter(SuekaDotMe::Jekyll::RejectFilter)
