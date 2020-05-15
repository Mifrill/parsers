require 'byebug'

class TestParser
  def initialize
    task(method: :first, data: 123)
  end

  def first
    puts __method__

    task(method: :second)
  end

  def second
    puts __method__

    %w[1 2].each do |item|
      task(method: :third, url: "https://www.google.com/webhp?newwindow=#{item}", data: item)
    end
  end

  def third
    puts __method__
    puts data

    fields do |field|
      field.id = data
      field.title = 'Truck'
    end

    yield fields
  end
end
