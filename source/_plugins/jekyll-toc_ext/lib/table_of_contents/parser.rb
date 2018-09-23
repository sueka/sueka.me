module Jekyll
  module TableOfContents
    class Parser
      private

      # parse logic is from html-pipeline toc_filter
      # https://github.com/jch/html-pipeline/blob/v1.1.0/lib/html/pipeline/toc_filter.rb
      def parse_content
        entries = []
        headers = Hash.new(0)

        # TODO: Use kramdown auto ids
        @doc.css(toc_headings).each do |node|
          text = node.text
          id = node.attributes['id'].value
          id.gsub!(PUNCTUATION_REGEXP, '') # remove punctuation
          id.gsub!(' ', '-') # replace spaces with dash

          uniq = headers[id] > 0 ? "-#{headers[id]}" : ''
          headers[id] += 1
          header_content = node.children.first
          next unless header_content

          entries << {
            id: id,
            uniq: uniq,
            text: text,
            node_name: node.name,
            content_node: header_content,
            h_num: node.name.delete('h').to_i
          }
        end

        entries
      end
    end
  end
end
