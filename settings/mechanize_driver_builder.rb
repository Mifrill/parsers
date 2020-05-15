class MechanizeDriverBuilder
  attr_accessor :driver

  def initialize
    self.driver = :mechanize
  end

  def register!
    return if Gem.win_platform?

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
end
