class Task
  attr_reader :queue, :threads

  def initialize
    @queue   = Queue.new
    @threads = []
  end

  def add(task)
    threads << Thread.new do
      queue << task
      puts "#{i} produced"
    end
  end

  def execute
    threads << Thread.new do
      value = queue.pop
      puts "consumed #{value}"
    end
  end

  def join
    threads.map(&:join)
  end
end
