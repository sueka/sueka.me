require 'yaml'

RSpec.describe 'sueka.me' do
  describe 'translation data' do
    subject { YAML.load_file('source/_data/translations.yml') }

    TRANSLATION_KEYS = %w[
      name
      about
      archives
      contents
      earlier
      home
      languages
      later
      next-and-previous-posts
      no-newer-posts
      no-older-posts
      read-more
      recent-posts
      related-posts
      see-more
      tags
      year-format
      month-format
      date-format
    ]

    it { is_expected.to all match(TRANSLATION_KEYS.append('langcode').map { |key| [key, String] }.to_h) }
    it { should include a_hash_including 'langcode' => 'en' }
    it { should include a_hash_including 'langcode' => 'ja' }
  end
end
