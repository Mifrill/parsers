Process::RLIMIT_NOFILE = 7 if Gem.win_platform?

require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'capybara-screenshot'
require 'selenium-webdriver'
require 'capybara/mechanize'

module Parser
  class Settings
    def initialize(
      driver = ENV.fetch('DRIVER', 'selenium').to_sym,
      browser: ENV.fetch('BROWSER', 'chrome').to_sym
    )

      case driver
      when :mechanize
        Capybara.register_driver driver do |_app|
          driver = Capybara::Mechanize::Driver.new('app')
          driver.configure do |agent|
            agent.log = Logger.new 'mech.log'
            agent.user_agent_alias = 'Mac Safari'
          end
          driver
        end
      when :selenium
        case browser
        when :firefox
          options = Selenium::WebDriver::Firefox::Options.new
          options.add_argument('--headless')
          browser_options = { marionette: true }.merge(options.as_json)
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
          raise 'Unknown browser'
        end

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

        Capybara.javascript_driver     = driver
        Capybara.default_max_wait_time = 10
      else
        raise 'Unknown driver'
      end

      Capybara.run_server     = false
      Capybara.default_driver = driver
      Capybara.app_host       = 'https://www.google.com'
    end
  end
end
