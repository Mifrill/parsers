# 1
arr = [1, 2, 3, 4]
arr.each { |el| puts el }

# 2
def run_block
  yield if block_given?
end

run_block do
  puts 'Hello world!'
end

# 3
class Array
  def random_each
    shuffle.each do |el|
      yield el
    end
  end
end

[1, 2, 3, 4, 5].random_each do |el|
  puts el
end

# 4
class Array
  def random_each(&b)
    p b
    shuffle.each do |el|
      yield el
    end
  end
end

[1, 2, 3, 4, 5].random_each do |el|
  puts el
end

# 5
def run_two_procs(a, b)
  a.call
  b.call
end

proc1 = proc do
  puts 'This is proc 1'
end

proc2 = proc do
  puts 'This is proc2'
end

run_two_procs proc1, proc2

# 6
def run_block
  p = Proc.new
  p.call
end

run_block do
  puts 'Hello world'
end

# 7
my_proc = proc do |a|
  puts "This is my proc and #{a} was passed to me"
end

my_proc.call(10)
my_proc.call(20)
my_proc[30]
my_proc === 40

# 8
several = proc { |number| number > 3 && number < 8 }
many    = proc { |number| number > 3 && number < 8 }
few     = proc { |number| number == 3 }
couple  = proc { |number| number == 2 }
none    = proc { |number| number == 0 }

0.upto(10) do |number|
  print "#{number} items is "

  case number
  when several
    puts 'several'
  when many
    puts 'many'
  when few
    puts 'a few'
  when couple
    puts 'a couple'
  when none
    puts 'none at all'
  else
    puts 'awesome'
  end
end

# 9
hello = lambda do # can change to proc
  puts 'This is proc1'
end

hello.call

# 10
hello = proc do |_a, _b, _c| # can't change to lambda
  puts 'This si proc1'
end

hello.call

# 11
def run_a_proc(p)
  puts 'Starting to run a proc'
  p.call
  puts "Finished running the proc\n\n"
end

def our_program
  run_a_proc -> { puts "I'm a lambda"; return }
  run_a_proc proc { puts "I'm a proc"; return }
end

our_program

# 12 Closures
def run_proc(p)
  p.call
end

name = 'Fred'
print_a_name = proc { puts name }
run_proc print_a_name

# 13
def multiple_generator(m)
  lambda do |n|
    n * m
  end
end

doubler = multiple_generator(2)
tripler = multiple_generator(3)

puts doubler[5] # => 10
puts tripler[10] # => 30

# 14
def run_proc(p)
  p.call
end

name = 'Fred'
print_a_name = proc { puts name }
name = 'John' # look like var is not used
run_proc print_a_name # John
