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
    sleep rand(i / 2) # simulate expense
    puts "consumed #{value}"
  end
end

[producer, consumer].map(&:join)

# Building custom Queue class

tasks    = []
mutex    = Mutex.new
cond_var = ConditionVariable.new
threads  = []

class Task
  def initialize
    @duration = rand
  end

  def execute
    sleep @duration
  end
end

# producer threads
threads += 2.times.map do
  Thread.new do
    5.times do # while true
      mutex.synchronize do
        tasks << Task.new
        cond_var.signal
        puts "Added task: #{tasks.last.inspect}"
      end
      # limit task production speed
      sleep 0.5
    end
  end
end

# consumer threads
threads += 5.times.map do
  Thread.new do
    5.times do # while true
      task = nil
      mutex.synchronize do
        cond_var.wait(mutex) while tasks.empty?
        # the `if tasks.count == 0` statement will never be true as the thread
        # will now only reach this line if the tasks array is not empty
        puts 'This thread has nothing to do' if tasks.count == 0
        # similarly, we can now remove the `if tasks.count > 0` check that
        # used to surround this code. We no longer need it as this code will
        # now only get executed if the tasks array is not empty.
        task = tasks.shift
        puts "Removed task: #{task.inspect}"
      end
      # Note that we have now removed `unless task.nil?` from this line as
      # our thread can only arrive here if there is indeed a task available.
      task.execute
    end
  end
end

threads.each { |t| t.join 1 } # to prevent fatal: No live threads left. Deadlock?

class SimpleQueue
  def initialize
    @elems    = []
    @mutex    = Mutex.new
    @cond_var = ConditionVariable.new
  end

  def <<(elem)
    @mutex.synchronize do
      @elems << elem
      @cond_var.signal
    end
  end

  def shift(blocking = true)
    @mutex.synchronize do
      @cond_var.wait(@mutex) while @elems.empty? if blocking

      @elems.shift
    end
  end
end

simple_queue = SimpleQueue.new
# this will print "blocking shift returned with: foo" after 5 seconds
# that is to say, the first thread will go to sleep until the second
# thread adds an element to the queue, thereby causing the first thread
# to be woken up again
threads = []
threads << Thread.new { puts "blocking shift returned with: #{simple_queue.shift}" }
threads << Thread.new { sleep 5; simple_queue << 'foo' }
threads.each(&:join)
