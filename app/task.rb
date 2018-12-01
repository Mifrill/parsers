require_relative 'session'

module Parser
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
      {
        fields: nil,
        data: data,
        page: session
      }.each do |key, value|
        parser.instance_variable_set "@#{key}", value
      end

      parser.send method do
        parser.store!
      end
    ensure
      session&.destroy
    end

    private

    def session
      @session ||= begin
        if url
          session = Parser::Session.new(driver)
          session.visit(url)
          PP.pp "#{self.class}. Current driver - #{driver}"
          session
        end
      end
    end
  end
end
