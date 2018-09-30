require 'capybara/rspec'
require 'rack/jekyll'

Capybara.app = Rack::Jekyll.new

RSpec.describe 'sueka.me' do
  describe 'home page' do
    subject { page }

    # no tests
  end
end
