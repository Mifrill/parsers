def counters_with_mutex
  mutex = Mutex.new
  counters = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  5.times.map do
    Thread.new do
      100000.times do
        mutex.synchronize do
          counters.map! { |counter| counter + 1 }
        end
      end
    end
  end.each(&:join)
  counters.inspect
end
def counters_without_mutex
  counters = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  5.times.map do
    Thread.new do
      100000.times do
        counters.map! { |counter| counter + 1 }
      end
    end
  end.each(&:join)
  counters.inspect
end
puts counters_with_mutex
# => [500000, 500000, 500000, 500000, 500000, 500000, 500000, 500000, 500000, 500000]
puts counters_without_mutex
# => [500000, 500000, 217716, 355114, 258086, 500000, 442370, 500000, 500000, 500000]
# note that we seem to have lost some increments here due to not using a mutex

mutex = Mutex.new
flags = [false, false, false, false, false, false, false, false, false, false]
threads = 50.times.map do
  Thread.new do
    100000.times do
      # don't do this! Reading from shared state requires a mutex!
      puts flags.to_s
      mutex.synchronize do
        flags.map! { |f| !f }
      end
    end
  end
end
threads.each(&:join)
# ruby practice/mutex.rb > output.log
# grep 'true, false' output.log | wc -l

class BankAccount
  def initialize(name, checking, savings)
    @name, @checking, @savings = name, checking, savings
    @lock = Mutex.new  # For thread safety
  end

  # Lock account and transfer money from savings to checking
  def transfer_from_savings(x)
    @lock.synchronize do
      @savings -= x
      @checking += x
    end
  end

  # Lock account and report current balances
  def report
    @lock.synchronize do
      "#@name\nChecking: #@checking\nSavings: #@savings"
    end
  end
end


queue = Queue.new

producer = Thread.new do
  5.times do |i|
    sleep rand(i) # simulate expense
    queue << i
    puts "#{i} produced"
  end
end

consumer = Thread.new do
  5.times do |i|
    value = queue.pop
    sleep rand(i/2) # simulate expense
    puts "consumed #{value}"
  end
end

[producer, consumer].map(&:join)
