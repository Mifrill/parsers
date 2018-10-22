require_relative 'runner'
require_relative 'task'

require 'pp'
require 'rest-client'

module Parsers
  DRIVER = :mechanize

  class << self
    def remote_request(request_url)
      begin
        response = RestClient.get request_url
      rescue RestClient::ResourceNotFound => error
        @retries ||= 0
        raise error if @retries > @max_retries

        @retries += 1
        retry
      end
      response
    end

    def build(parser)
      require_relative "../parsers/#{parse_name(parser)}"
      klass = parse_class(parser)
      klass.prepend self
      klass.attr_reader :data
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

    mutex = Mutex.new

    loop do
      mutex.synchronize do
        @runner.execute_task
        @runner.run_threads
      end

      break if @runner.done?
    end
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

  def request(*args)
    url, = args
    Parsers.remote_request(url)
  end
end
