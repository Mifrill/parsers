require 'byebug'

class TestParser
  def initialize
    @config = { start: { method: :first, url: "http://google.com" }}
  end

  def first
    puts __method__
    yield task(parser: self.class, method: :second, url: "http://google.com/", data: {})
  end

  def second
    puts __method__
    yield task(parser: self.class, method: :third, url: "http://google.com/", data: {})
  end

  def third
    puts __method__
    yield -> { puts 'done' }.call
  end
end
