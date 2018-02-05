RSpec.describe 'sueka.me' do
  describe 'home page' do
    feature 'multilanguage' do
      context 'with English' do
        before { visit '/index.html' }
        it { expect(page).to have_link('עברית', href: '/index.he.html') }
        it { expect(page).to have_link('日本語', href: '/index.ja.html') }
      end
      context 'with Japanese' do
        before { visit '/index.ja.html' }
        it { expect(page).to have_link('English', href: '/') }
        it { expect(page).to have_link('עברית', href: '/index.he.html') }
      end
      context 'with Hebrew' do
        before { visit '/index.he.html' }
        it { expect(page).to have_link('English', href: '/') }
        it { expect(page).to have_link('日本語', href: '/index.ja.html') }
      end
    end
  end
end
