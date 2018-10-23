require_relative 'runner'
require_relative 'task'

require 'pp'

module Parsers
  DRIVER  = :mechanize
  READERS = %i[data page].freeze

  class << self
    def build(parser)
      require_relative "../parsers/#{parse_name(parser)}"
      klass = parse_class(parser)
      klass.prepend self
      Parsers::READERS.each { |reader| klass.attr_reader reader }
      klass
    end

    private

    def parse_name(text)
      text.to_s.split(/(?=[A-Z])\b/).join('_').downcase + '_parser'
    end

    def parse_class(text)
      Kernel.const_get("#{text}Parser")
    end
  end

  def initialize
    @runner = Parsers::Runner.new
    super
    @runner.start
  end

  private

  def task(args)
    task = begin
      Parsers::Task.new(
        parser: self,
        driver: self.class::DRIVER,
        method: args[:method],
        url:    args[:url],
        data:   args[:data]
      )
    end

    @runner.add_task task

    task.show
    task
  end
end
