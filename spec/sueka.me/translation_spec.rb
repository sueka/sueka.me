require 'yaml'

RSpec.describe 'sueka.me' do
  describe 'translation data' do
    let(:translations) { YAML.load_file('source/_data/translations.yml') }
    it do
      expect(translations).to all match(
        'langcode' => anything,
        'name'          => anything,
        'languages'     => anything,
        'tags'          => anything,
        'archives'      => anything,
        'search'        => anything,
        'contents'      => anything,
        'recent-posts'  => anything,
        'related-posts' => anything,
        'date-format'   => anything
      )
    end
    it { expect(translations).to include include 'langcode' => 'en' }
    it { expect(translations).to include include 'langcode' => 'ja' }
  end
end
