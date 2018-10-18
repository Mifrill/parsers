def show_numbers(numbers = 10)
  i = 0
  while i < numbers
    yield i
    i += 1
  end
end

show_numbers do |number|
  puts "the numbers is #{number}"
  number *= 2 # does not matter
end

def explicit(&block)
  raise LocalJumpError, 'No block given.' unless block

  yield
end

explicit do
  puts 'From explicit block'
end

begin
  explicit
rescue LocalJumpError => e
  puts "#{e.class} #{e.message}"
end

def implicit
  raise LocalJumpError, 'No block given.' unless block_given?

  yield
end

implicit do
  puts 'From Implicit block'
end

begin
  implicit
rescue LocalJumpError => e
  puts "#{e.class} #{e.message}"
end

# ------------------------------------------------

class Menu
  include Enumerable

  def each
    yield 'pizza'
    yield 'spaghetti'
    yield 'salad'
    yield 'water'
    yield 'bread'
  end
end

menu_options = Menu.new

menu_options.each do |item|
  puts "would you like : #{item}"
end

p menu_options.find { |item| item == 'pizza' }
p menu_options.select { |item| item.size <= 5 }
p menu_options.reject { |item| item.size <= 5 }
p menu_options.first
p menu_options.take(2)
p menu_options.drop(2)
p menu_options.min
p menu_options.max
p menu_options.sort
menu_options.reverse_each { |item| puts item }
