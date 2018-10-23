require_relative 'runner'
require_relative 'task'

require 'pp'

module Parsers
  DRIVER = :mechanize

  attr_reader :data, :page

  class << self
    def build(parser)
      require_relative "../parsers/#{parse_name(parser)}"
      klass = parse_class(parser)
      klass.prepend self
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
        driver: args[:driver] || self.class::DRIVER,
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
