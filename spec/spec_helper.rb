require 'coveralls'
Coveralls.wear!

require 'capybara/rspec'
require 'capybara-screenshot/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.filter_run_when_matching :focus
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
    end
    SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
  end
end

require_relative '../app/app'
