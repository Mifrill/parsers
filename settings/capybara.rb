require 'rubygems'
require 'capybara-screenshot'
require 'selenium-webdriver'
require 'capybara/dsl'

browser = (ENV['BROWSER'] || 'chrome').to_sym

case browser
when :firefox
when :chrome
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-gpu')
  options.add_argument('--remote-debugging-port=9222')

  chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
  chrome_options = chrome_bin ? { 'chromeOptions' => { 'binary' => chrome_bin } } : options.as_json

  Capybara.run_server = false
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(
        app,
        browser: :chrome,
        desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(chrome_options)
    )
  end
  Capybara.default_driver = :chrome
  Capybara::Screenshot.register_driver(:chrome) do |driver, path|
    driver.browser.save_screenshot(path)
  end

  Capybara.default_driver = :chrome
  Capybara.javascript_driver = :chrome
end

Capybara.default_max_wait_time = 10
Capybara.app_host = 'https://www.google.com'
Capybara::Screenshot.append_timestamp = true
Capybara.save_path = 'tmp/report'
Capybara::Screenshot.prune_strategy = :keep_last_run
