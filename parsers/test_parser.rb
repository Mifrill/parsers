require 'byebug'

class TestParser
  DRIVER = :selenium

  def initialize
    task(method: :first, data: 123)
  end

  def first
    puts __method__

    2.times do
      task(method: :second)
    end
  end

  def second
    puts __method__

    2.times do
      task(method: :third, url: 'http://google.com/', data: 321)
    end
  end

  def third
    puts __method__

    puts data
    -> { puts 'done' }.call
  end
end
