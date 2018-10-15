require 'yaml'

RSpec.describe 'sueka.me' do
  describe 'tag translation data' do
    subject { YAML.load_file('source/_data/tag-translations.yml') }

    TAG_TRANSLATION_KEYS = %w[
      clipboard
      io-type-constructor
      javascript
      memo
      microservice
      poem
      scala
      sh
      tips
      type
    ].freeze

    it { is_expected.to all match(TAG_TRANSLATION_KEYS.append('langcode').map { |key| [key, String] }.to_h) }
    it { should include a_hash_including 'langcode' => 'en' }
    it { should include a_hash_including 'langcode' => 'ja' }
  end
end
