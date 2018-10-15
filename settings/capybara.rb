require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'capybara-screenshot'
require 'selenium-webdriver'

browser = (ENV['BROWSER'] || 'chrome').to_sym

case browser
when :firefox
  options = Selenium::WebDriver::Firefox::Options.new
  options.add_argument('--headless')
  browser_options = { marionette: false }.merge(options.as_json)
when :chrome
  chrome_bin      = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
  browser_options = begin
    if chrome_bin
      { 'chromeOptions' => { 'binary' => chrome_bin } }
    else
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-gpu')
      options.add_argument('--remote-debugging-port=9222')
      options.as_json
    end
  end
else
  raise "Unknown browser"
end

capabilities = Selenium::WebDriver::Remote::Capabilities.send(browser, browser_options)

Capybara.register_driver browser do |app|
  Capybara::Selenium::Driver.new(
    app,  browser: browser, desired_capabilities: capabilities
  )
end

Capybara::Screenshot.register_driver(browser) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara.run_server = false

Capybara.default_driver    = browser
Capybara.javascript_driver = browser

Capybara.default_max_wait_time        = 10
Capybara.app_host                     = 'https://www.google.com'
Capybara.save_path                    = 'tmp/report'
Capybara::Screenshot.append_timestamp = true
Capybara::Screenshot.prune_strategy   = :keep_last_run
