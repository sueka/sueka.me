require 'capybara'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new app, :js_errors => true, :timeout => 60
end

Capybara.configure do |c|
  c.run_server = false
  c.default_driver = :poltergeist
  c.app_host = 'http://0.0.0.0:4000'
end

RSpec.configure do |c|
  c.include Capybara::DSL
end
