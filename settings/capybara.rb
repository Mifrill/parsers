require 'rubygems'
require 'capybara-screenshot'
require 'selenium-webdriver'
require 'capybara/dsl'

Capybara.run_server = false
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.default_driver = :chrome
Capybara.app_host = 'http://www.dns-shop.ru/'
Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end
Capybara::Screenshot.append_timestamp = true
Capybara.save_path = 'tmp/report'
Capybara.default_wait_time = 5
