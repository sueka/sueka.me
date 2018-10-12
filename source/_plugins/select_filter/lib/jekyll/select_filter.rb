module SuekaDotMe
  module Jekyll
    module SelectFilter
      def select(xs, attr_name, replacement)
        xs.select { |x| x.data[attr_name] == replacement }
      end
    end
  end
end

Liquid::Template.register_filter(SuekaDotMe::Jekyll::SelectFilter)
