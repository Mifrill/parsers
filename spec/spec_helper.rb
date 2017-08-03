require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.filter_run_when_matching :focus
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara.default_wait_time = 20
Capybara.default_driver = :chrome
Capybara.javascript_driver = :chrome
Capybara.app_host = 'https://www.zzap.ru'
Capybara::Screenshot.append_timestamp = true
Capybara.save_path = 'tmp/capybara'
Capybara::Screenshot.prune_strategy = :keep_last_run

require 'images_by_url'
require 'open-uri'
require 'nokogiri'

if ENV['ENV'] == 'test'
  puts 'CodeCoverage Enabled'
  require 'simplecov'
  if ENV['CI']
    require 'codecov'
    require 'codeclimate-test-reporter'
    SimpleCov.start
    SimpleCov.formatter = SimpleCov::Formatter::Codecov
  else
    SimpleCov.start do
      add_filter 'some/path'
    end
  end
end

require_relative '../app/app'

if ENV['BROWSER_MIN'] == 'on'
  require 'headless'
  headless = Headless.new
  headless.start
end
