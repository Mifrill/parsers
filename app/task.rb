module Parsers
  class Task
    include Capybara::DSL

    attr_reader :parser, :method, :url, :data

    def initialize(parser:, method:, url:, data:)
      @parser, @method, @url, @data = parser, method, url, data
    end

    def execute
      visit(url)

      parser.new.send method do |result|
        result
      end
    end
  end
end
