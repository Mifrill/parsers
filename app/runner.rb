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

    def run(parser:, method:, url:, data:)
      parser.send method do |result|
        byebug
        result
      end
    end
  end
end
