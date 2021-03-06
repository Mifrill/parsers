require_relative 'runner'
require_relative 'task'
require_relative 'fields'
require_relative 'storage'

require 'forwardable'
require 'open-uri'
require 'nokogiri'
require 'pp'

module Parser
  extend Forwardable

  DEBUG = false
  DRIVER = :cuprite

  delegate %i[xpath at_xpath] => :html
  attr_reader :data, :page, :url

  class << self
    def build(parser)
      require_relative "../parsers/#{parse_name(parser)}"
      klass = parse_class(parser)
      klass.prepend self
      klass
    end

    private

    def parse_name(text)
      "#{text.to_s.split(/(?=[A-Z])\b/).join('_').downcase}_parser"
    end

    def parse_class(text)
      Kernel.const_get("#{text}Parser")
    end
  end

  def initialize
    @runner = Parser::Runner.new(debug: DEBUG)
    super
    @runner.start
  end

  def fields
    if block_given?
      @fields = Fields.new do |field|
        yield field
      end.fields
    else
      @fields
    end
  end

  def store!
    @storage ||= Parser::Storage.new(self.class)
    @storage << fields
  end

  private

  def task(args)
    task = Parser::Task.new(
      parser: self,
      driver: args[:driver] || self.class::DRIVER,
      method: args[:method],
      url: args[:url],
      data: args[:data]
    )
    @runner.add_task task
  end

  def html
    Nokogiri::HTML.parse(page.html)
  end
end
