require 'yaml'

RSpec.describe 'sueka.me' do
  describe 'translation data' do
    let(:translations) { YAML.load_file('source/_data/translations.yml') }
    subject { translations }

    it do
      is_expected.to all match(
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
    it { should include a_hash_including 'langcode' => 'en' }
    it { should include a_hash_including 'langcode' => 'ja' }
  end
end
