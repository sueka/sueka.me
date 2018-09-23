module Kramdown
  module Parser
    class Kramdown
      def initialize(source, options)
        super

        reset_env

        @alds = {}
        @footnotes = {}
        @link_defs = {}
        update_link_definitions(@options[:link_defs])

        @block_parsers = [:blank_line, :codeblock, :codeblock_fenced, :blockquote, :atx_header,
                          :horizontal_rule, :list, :definition_list, :block_html, :setext_header,
                          :table, :footnote_definition, :link_definition, :abbrev_definition,
                          :block_extensions, :eob_marker, :paragraph]
        @span_parsers =  [:emphasis, :codespan, :autolink, :span_html, :footnote_marker, :link,
                          :smart_quotes, :span_extensions, :html_entity, :typographic_syms,
                          :line_break, :escaped_chars]
      end
    end
  end
end
