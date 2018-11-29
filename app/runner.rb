module Parser
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

    def start
      mutex = Mutex.new

      loop do
        mutex.synchronize do
          add_task_execute
          run_threads
        end

        break if empty_queue?
      end
    end

    def add_task_execute
      return PP.pp('No existed tasks') if empty_queue?

      threads << Thread.new do
        task = queue.pop
        puts "consumed: #{task}"
        task.execute
      end
    end

    def run_threads
      until threads.empty?
        begin
          threads.shift.join
        rescue ThreadError => e
          print_exception(e, true)
        rescue StandardError => e
          print_exception(e, false)
        end
      end
    end

    private

    def empty_queue?
      queue.empty?
    end

    def print_exception(exception, explicit)
      puts "[#{explicit ? 'EXPLICIT' : 'INEXPLICIT'}] #{exception.class}: #{exception.message}"
      puts exception.backtrace.join("\n")
    end
  end
end
