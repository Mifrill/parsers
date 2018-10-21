require 'byebug'

class TestParser
  def initialize
    @config = { start: { method: :first, url: 'http://google.com' } }
  end

  def first
    puts __method__

    2.times do
      task(parser: self, method: :second, url: 'http://google.com/', data: {})
    end
  end

  def second
    puts __method__

    2.times do
      task(parser: self, method: :third, url: 'http://google.com/', data: {})
    end
  end

  def third
    puts __method__
    -> { puts 'done' }.call
  end
end
