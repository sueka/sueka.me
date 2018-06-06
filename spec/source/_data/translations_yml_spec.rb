require 'yaml'

RSpec.describe 'sueka.me' do
  describe 'translation data' do
    let(:translations) { YAML.load_file('source/_data/translations.yml') }
    it do
      expect(translations).to all match(
        'langcode'      => String,
        'name'          => String,
        'languages'     => String,
        'tags'          => String,
        'archives'      => String,
        'contents'      => String,
        'recent-posts'  => String,
        'related-posts' => String,
        'date-format'   => String
      )
    end
    it { expect(translations).to include include 'langcode' => 'en' }
    it { expect(translations).to include include 'langcode' => 'ja' }
  end
end
