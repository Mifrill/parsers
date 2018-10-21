module Parsers
  class Runner
    attr_reader :queue, :threads

    def initialize
      @queue   = Queue.new
      @threads = []
    end

    def add_task(task)
      threads << Thread.new do
        queue << task
        puts "produced: #{task}"
      end
    end

    def execute_task
      threads << Thread.new do
        task = queue.pop
        puts "consumed: #{task}"
        task.execute
      end
    end

    def run_threads
      threads.map(&:join)
    end

    def done?
      queue.empty?
    end
  end
end
