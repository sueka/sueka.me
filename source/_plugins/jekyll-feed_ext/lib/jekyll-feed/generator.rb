# The original source (https://github.com/jekyll/jekyll-feed/blob/v0.11.0/lib/jekyll-feed/generator.rb) is provided under the MIT License (https://github.com/jekyll/jekyll-feed/blob/v0.11.0/LICENSE.txt).
#
# Original Copyright (c) 2015-present Ben Balter and jekyll-feed contributors

module JekyllFeed
  class Generator < Jekyll::Generator
    private def feed_source_path
      @feed_source_path ||= File.expand_path "feed.xml", __dir__
    end
  end
end
