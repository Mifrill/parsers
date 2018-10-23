require_relative '../settings/capybara'

module Parser
  class Session
    include Capybara::DSL

    attr_reader :driver, :session

    def initialize(driver)
      @driver  = driver
      @session = Capybara::Session.new(driver)
    end

    def visit(url)
      session.visit(url)
    end

    def destroy
      session.driver.quit
    end
  end
end
