RSpec.describe 'sueka.me' do
  describe 'home page' do
    feature 'multilanguage' do
      context 'with English' do
        before { visit '/index.html' }
        it { expect(page).to have_link('日本語', href: '/index.ja.html') }
      end
      context 'with Japanese' do
        before { visit '/index.ja.html' }
        it { expect(page).to have_link('English', href: '/') }
      end
    end
  end
end
