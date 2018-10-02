require 'yaml'

RSpec.describe 'sueka.me' do
  describe 'tag translation data' do
    let(:translations) { YAML.load_file('source/_data/tag-translations.yml') }
    subject { translations }

    it do
      is_expected.to all match(
        'clipboard'           => String,
        'io-type-constructor' => String,
        'javascript'          => String,
        'memo'                => String,
        'microservice'        => String,
        'poem'                => String,
        'scala'               => String,
        'scale-cube'          => String,
        'sh'                  => String,
        'tips'                => String,
        'type'                => String,
      )
    end
    it { should include a_hash_including 'langcode' => 'en' }
    it { should include a_hash_including 'langcode' => 'ja' }
  end
end
