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
  raise LocalJumpError, "No block given." unless block
  block.call
end

explicit do
  puts "From explicit block"
end

begin
  explicit
rescue LocalJumpError => e
  puts "#{e.class} #{e.message}"
end

def implicit
  raise LocalJumpError, "No block given." unless block_given?
  yield
end

implicit do
  puts "From Implicit block"
end

begin
  implicit
rescue LocalJumpError => e
  puts "#{e.class} #{e.message}"
end
