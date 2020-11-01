# -*- frozen_string_literal: true -*-

# The original source
# (https://github.com/linjer/jekyll-katex/blob/v1.0.0/lib/jekyll/tags/katex.rb) is provided
# under the MIT License (https://github.com/linjer/jekyll-katex/blob/v1.0.0/LICENSE.txt).
#
# Original Copyright (c) 2016 Jerry Lin

module Jekyll
  module Tags
    # :nodoc:
    class Katex
      LOG_TOPIC = 'Katex Block:'
      KATEX ||= Jekyll::Katex::KATEX_JS

      def render(context)
        latex_source = super
        rendering_options = Jekyll::Katex::Configuration.global_rendering_options.merge(
          displayMode: @display
        )

        if rendering_options[:displayMode]
          <<~EOS.strip.gsub(/\n\s*/) { ' ' }
            <div class="katex-container">
              #{KATEX.call('katex.renderToString', latex_source, rendering_options)}
            </div>
          EOS
        else
          <<~EOS.strip.gsub(/\n\s*/) { ' ' }
            <span class="katex-wrapper">
              #{KATEX.call('katex.renderToString', latex_source, rendering_options)}
            </span>
          EOS
        end
      end
    end
  end
end
