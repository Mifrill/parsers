class Benchmarker
  def self.go(how_many = 1, &block)
    puts "-----------Benchmak started-----------"
    start_time = Time.now
    puts "Start time: #{start_time}\n\n"
    how_many.times do |a|
      print "."
      block.call
    end
    print "\n\n"
    end_time = Time.now
    puts "End time: #{end_time}"
    puts "-----------Benchmark finished-----------"
    puts "Result: #{end_time - start_time} seconds"
  end
end

Benchmarker.go 5 do
  time = rand 0.1..1.0
  sleep time
end
