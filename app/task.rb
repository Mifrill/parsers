require_relative 'session'

module Parsers
  class Task
    attr_reader :parser, :driver, :method, :url, :data

    def initialize(parser:, driver:, method:, url:, data:)
      @parser = parser
      @driver = driver
      @method = method
      @url    = url
      @data   = data
    end

    def show
      PP.pp self
    end

    def execute
      if url
        @session = Session.new(driver)
        @session.visit(url)
      end

      {
        data: data,
        page: @session
      }.each do |key, value|
        parser.instance_variable_set "@#{key}", value
      end

      parser.send method
    ensure
      @session&.destroy
    end
  end
end
