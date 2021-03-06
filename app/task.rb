require_relative 'session'

module Parser
  class Task
    attr_reader :parser, :driver, :method, :url, :data, :debug

    def initialize(parser:, driver:, method:, url:, data:)
      @parser = parser
      @driver = driver
      @method = method
      @url = url
      @data = data
      @debug = parser.class::DEBUG

      show if debug
    end

    def show
      PP.pp self
    end

    def execute
      set_instance_variables!

      parser.send method do
        parser.store!
      end
    ensure
      session&.destroy
    end

    private

    def session
      @session ||=
        if url
          session = Parser::Session.new(driver)
          session.visit(url)
          PP.pp "#{self.class}. Current driver - #{driver}" if debug
          session
        end
    end

    def set_instance_variables!
      {
        fields: nil,
        data: data,
        page: session,
        url: Addressable::URI.parse(url)
      }.each do |key, value|
        parser.instance_variable_set "@#{key}", value
      end
    end
  end
end
