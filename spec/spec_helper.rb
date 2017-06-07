require_relative '../app/app'

require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara.default_wait_time = 500
Capybara.default_driver = :chrome
Capybara.javascript_driver = :chrome
Capybara.app_host = 'http://www.dns-shop.ru/'
Capybara::Screenshot.append_timestamp = true
Capybara.save_path = 'tmp/capybara'
Capybara::Screenshot.prune_strategy = :keep_last_run

require 'images_by_url'
require 'open-uri'
require 'nokogiri'
