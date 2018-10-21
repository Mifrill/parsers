module Parsers
  class Task
    include Capybara::DSL

    attr_reader :parser, :method, :url, :data

    def initialize(parser:, method:, url:, data:)
      @parser, @method, @url, @data = parser, method, url, data
    end

    def show
      PP.pp self
    end

    def execute
      visit(url)

      parser.send method
    end
  end
end
