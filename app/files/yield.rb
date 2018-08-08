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
