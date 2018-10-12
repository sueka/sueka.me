module SuekaDotMe
  module Jekyll
    module LimitFilter
      def limit(xs, size)
        xs.take size
      end
    end
  end
end

Liquid::Template.register_filter(SuekaDotMe::Jekyll::LimitFilter)
