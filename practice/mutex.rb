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
