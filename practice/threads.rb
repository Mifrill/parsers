a = [1, 2, 3, 4]
threads = []
for i in a
  threads << Thread.new(i) do |local|
    puts "starting a new thread - #{local}"
    new = local * 10
    puts "#{local} multiplied with 10 is #{new}"
    puts "ending the thread - #{local}"
  end
end

puts Thread.list
threads.each { |a| a.join }
