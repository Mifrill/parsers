require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'capybara-screenshot'
require 'selenium-webdriver'
require 'capybara/mechanize' unless Gem.win_platform?

module Parser
  class Settings
    attr_reader :driver, :browser

    def initialize(
      driver = ENV.fetch('DRIVER', 'selenium').to_sym,
      browser: ENV.fetch('BROWSER', 'chrome').to_sym
    )
      @driver  = driver
      @browser = browser

      build_driver!

      Capybara.default_driver        = driver
      Capybara.default_selector      = :xpath
      Capybara.run_server            = false
      Capybara.default_max_wait_time = 10
      Capybara.app_host              = 'https://www.google.com'
    end

    private

    def build_driver!
      case driver
      when :mechanize
        build_mechanize_driver
      when :selenium
        build_selenium_driver
      else
        raise 'Unknown driver'
      end
    end

    def build_mechanize_driver
      Capybara.register_driver driver do |_app|
        driver = Capybara::Mechanize::Driver.new('app')
        driver.configure do |agent|
          agent.log = Logger.new 'mech.log'
          agent.user_agent_alias = 'Mac Safari'
        end
        driver
      end
    end

    def build_selenium_driver
      capabilities = Selenium::WebDriver::Remote::Capabilities.send(browser, browser_options)

      Capybara.register_driver driver do |app|
        Capybara::Selenium::Driver.new(
          app, browser: browser, desired_capabilities: capabilities
        )
      end

      Capybara::Screenshot.register_driver(driver) do |current_driver, path|
        current_driver.browser.save_screenshot(path)
      end

      Capybara.save_path                    = 'tmp/report'
      Capybara::Screenshot.append_timestamp = true
      Capybara::Screenshot.prune_strategy   = :keep_last_run
      Capybara.javascript_driver            = driver
    end

    def browser_options
      case browser
      when :firefox
        options = Selenium::WebDriver::Firefox::Options.new
        options.add_argument('--headless')
        { marionette: true }.merge(options.as_json)
      when :chrome
        chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
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
      else
        raise 'Unknown browser'
      end
    end
  end
end
