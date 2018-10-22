require_relative '../settings/capybara'

module Parsers
  class Task
    MODULES = [Capybara::DSL]

    attr_reader :parser, :method, :url, :data

    def initialize(parser:, method:, url:, data:)
      @parser = parser
      @method = method
      @url    = url
      @data   = data

      MODULES.each do |m|
        parser.class.include m
        self.class.include m
      end
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
