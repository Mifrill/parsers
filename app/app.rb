require_relative '../settings/capybara'
require_relative 'runner'
require_relative 'task'

require 'pp'
require 'rest-client'

module Parsers
  class << self
    def remote_request(request_url)
      begin
        response = RestClient.get request_url
      rescue RestClient::ResourceNotFound => error
        @retries ||= 0
        if @retries < @max_retries
          @retries += 1
          retry
        else
          raise error
        end
      end
      response
    end

    def build_parser(parser)
      require_relative "../parsers/#{parse_name(parser)}"
      klass = parse_class(parser)
      klass.include self, Capybara::DSL
      klass.attr_reader :config
      klass.new
    end

    private

    def parse_name(text)
      text.to_s.split(/(?=[A-Z])\b/).join('_').downcase + '_parser'
    end

    def parse_class(text)
      Kernel.const_get("#{text}Parser")
    end
  end

  def start
    runner.add_task first_task

    loop do
      runner.execute_task
      runner.run_threads

      break if runner.done?
    end
  end

  def task(args)
    task = Task.new args
    runner.add_task task
    task.show
    task
  end

  def request(*args)
    url, = args
    Parsers.remote_request(url)
  end

  private

  def runner
    @@runner ||= Runner.new
  end

  def first_task
    Task.new(
      parser: self,
      method: config.dig(:start, :method),
      url:    config.dig(:start, :url),
      data:   {}
    )
  end
end
