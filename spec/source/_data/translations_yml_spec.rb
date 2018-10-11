require 'yaml'

RSpec.describe 'sueka.me' do
  describe 'translation data' do
    let(:translations) { YAML.load_file('source/_data/translations.yml') }
    subject { translations }

    it do
      is_expected.to all match(
        'langcode'                => String,
        'name'                    => String,
        'about'                   => String,
        'archives'                => String,
        'contents'                => String,
        'earlier'                 => String,
        'home'                    => String,
        'languages'               => String,
        'later'                   => String,
        'next-and-previous-posts' => String,
        'read-more'               => String,
        'recent-posts'            => String,
        'related-posts'           => String,
        'see-more'                => String,
        'tags'                    => String,
        'year-format'             => String,
        'month-format'            => String,
        'date-format'             => String,
      )
    end
    it { should include a_hash_including 'langcode' => 'en' }
    it { should include a_hash_including 'langcode' => 'ja' }
  end
end
