require 'byebug'

class TestParser
  def initialize
    @config = { start: :parse, url: "http://google.com" }
  end

  def first
    puts __method__
    yield Runner.run(parser: self.class, method: :second, url: nil, data: {})
  end

  def second
    puts __method__
    yield Runner.run(parser: self.class, method: :third, url: nil, data: {})
  end

  def third
    puts __method__
    yield -> { puts 'done' }.call
  end
end
