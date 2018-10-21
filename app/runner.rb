module Parsers
  class Runner
    attr_reader :queue, :threads

    def initialize
      @queue   = Queue.new
      @threads = []
    end

    def <<(task)
      threads << Thread.new do
        queue << task
        puts "produced: #{task}"
      end
    end

    def execute
      threads << Thread.new do
        value = queue.pop
        puts "consumed: #{value}"
        value.execute
      end
    end

    def join
      threads.map(&:join)
    end
  end
end
