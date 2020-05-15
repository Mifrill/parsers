require 'capybara'
require 'capybara/dsl'
require_relative 'cuprite_driver_builder'
require_relative 'mechanize_driver_builder'
require_relative 'selenium_driver_builder'

module Parser
  class Settings
    attr_accessor :driver, :browser

    def initialize(
      driver = ENV.fetch('DRIVER', 'selenium').to_sym,
      browser: ENV.fetch('BROWSER', 'chrome').to_sym
    )
      self.driver = driver
      self.browser = browser

      build_driver!

      Capybara.default_driver = driver
      Capybara.default_selector = :xpath
      Capybara.run_server = false
      Capybara.default_max_wait_time = 10
      Capybara.app_host = 'https://www.google.com'
    end

    private

    def build_driver!
      case driver
      when :mechanize
        MechanizeDriverBuilder.new.register!
      when :selenium
        SeleniumDriverBuilder.new(browser: browser).register!
      when :cuprite
        CupriteDriverBuilder.new.register!
      else
        raise 'Unknown driver'
      end
    end
  end
end
