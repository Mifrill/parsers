require 'coveralls'
Coveralls.wear!

require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'vcr'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.filter_run_when_matching :focus

  # Add VCR to all tests
  VCR.configure do |c|
    c.cassette_library_dir = 'spec/cassettes'
    c.hook_into :webmock
    c.configure_rspec_metadata!
    c.ignore_localhost = true
  end
end

require 'images_by_url'
require 'open-uri'
require 'nokogiri'

if ENV['ENV'] == 'test'
  puts 'CodeCoverage Enabled'
  require 'simplecov'
  if ENV['CI']
    require 'codecov'
    SimpleCov.start
    SimpleCov.formatter = SimpleCov::Formatter::Codecov
  else
    SimpleCov.start do
      add_filter 'spec/'
      add_filter 'settings/'
    end
    SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
  end
end

require_relative '../app/app'
