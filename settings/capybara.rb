require 'capybara'
require 'capybara/dsl'

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
        return if Gem.win_platform?

        register_mechanize_driver!
      when :selenium
        register_selenium_driver!
        build_screenshot_options!
      when :cuprite
        register_cuprite_driver!
      else
        raise 'Unknown driver'
      end
    end

    def register_cuprite_driver!
      require 'capybara/cuprite'

      Capybara.register_driver driver do |app|
        Capybara::Cuprite::Driver.new(app, window_size: [1200, 800])
      end

      Capybara.javascript_driver = driver
    end

    def register_mechanize_driver!
      require 'capybara/mechanize'

      Capybara.register_driver driver do |_app|
        driver = Capybara::Mechanize::Driver.new('app')
        driver.configure do |agent|
          agent.log = Logger.new 'mech.log'
          agent.user_agent_alias = 'Mac Safari'
        end
        driver
      end
    end

    def register_selenium_driver!
      require 'selenium-webdriver'

      capabilities = Selenium::WebDriver::Remote::Capabilities.send(browser, browser_options)
      Capybara.register_driver driver do |app|
        Capybara::Selenium::Driver.new(
          app, browser: browser, desired_capabilities: capabilities
        )
      end

      Capybara.javascript_driver = driver
    end

    def browser_options
      case browser
      when :firefox
        build_firefox_options
      when :chrome
        build_chrome_options
      else
        raise 'Unknown browser'
      end
    end

    def build_firefox_options
      options = Selenium::WebDriver::Firefox::Options.new
      options.add_argument('--headless')
      { marionette: true }.merge(options.as_json)
    end

    def build_chrome_options
      chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
      if chrome_bin
        { 'chromeOptions' => { 'binary' => chrome_bin } }
      else
        headless_native_chrome_options
      end
    end

    def headless_native_chrome_options
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-gpu')
      options.add_argument('--remote-debugging-port=9222')
      options.as_json
    end

    def build_screenshot_options!
      require 'capybara-screenshot'

      Capybara::Screenshot.register_driver(driver) do |current_driver, path|
        current_driver.browser.save_screenshot(path)
      end

      Capybara::Screenshot.append_timestamp = true
      Capybara::Screenshot.prune_strategy   = :keep_last_run
      Capybara.save_path                    = 'tmp/screenshot'
    end
  end
end
