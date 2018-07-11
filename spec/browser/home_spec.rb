require 'capybara/rspec'
require 'rack/jekyll'

Capybara.app = Rack::Jekyll.new

RSpec.describe 'sueka.me' do
  describe 'home page' do
    subject { page }

    feature 'multilingual' do
      context 'with English' do
        before { visit '/index.html' }
        it { should have_link('日本語', href: '/index.ja.html', exact: true) }
      end
      context 'with Japanese' do
        before { visit '/index.ja.html' }
        it { should have_link('English', href: '/', exact: true) }
      end
    end
  end
end
