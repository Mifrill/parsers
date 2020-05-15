class CupriteDriverBuilder
  attr_accessor :driver

  def initialize
    self.driver = :cuprite
  end

  def register!
    require 'capybara/cuprite'

    Capybara.register_driver driver do |app|
      Capybara::Cuprite::Driver.new(app, window_size: [1200, 800])
    end

    Capybara.javascript_driver = driver
  end
end
