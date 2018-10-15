require 'contracts'

module SuekaDotMe
  module Jekyll
    # :nodoc:
    module LimitFilter
      include Contracts::Core

      Contract Array, Integer => Array
      def limit(xs, size)
        xs.take(size)
      end
    end
  end
end

Liquid::Template.register_filter(SuekaDotMe::Jekyll::LimitFilter)
