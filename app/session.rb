require_relative '../settings/capybara'

module Parser
  class Session
    include Capybara::DSL

    attr_reader :driver, :session

    def initialize(driver)
      @driver = driver
      @settings = Parser::Settings.new(driver)
      @session = Capybara::Session.new(driver)
    end

    def destroy
      case driver
      when :cuprite, :selenium
        session.driver.quit
      when :mechanize
        session.driver.browser.agent.shutdown
      end
    end
  end
end
