# frozen_string_literal: true

unless Gem.win_platform?
  style_check = `bundle exec rubocop`
  if !style_check =~ /files inspected, no offenses detected/ || !style_check =~ /Lint\/Debugger/
    print style_check
    abort('Style offences detected')
  end
end

require 'coveralls'
Coveralls.wear!

require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'vcr'
require 'webmock'

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

if ENV['ENV'] == 'test'
  puts 'CodeCoverage Enabled'
  require 'simplecov'

  SimpleCov.start do
    add_filter 'spec/'
    add_filter 'settings/'
  end

  if ENV['CI']
    require 'codecov'
    SimpleCov.formatter = SimpleCov::Formatter::Codecov
  else
    SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
  end
end

require_relative '../app/app'

driver = ENV.fetch('DRIVER', 'selenium').to_sym
Parser::Settings.new(driver)
