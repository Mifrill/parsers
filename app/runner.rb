module Parsers
  class Runner
    def initialize
      @tasks = []
    end

    def << (args)
      @tasks << args
    end

    def each(&block)
      @tasks.each(&block)
    end
  end
end
