require_relative '../settings/capybara'
require_relative 'runner'
require_relative 'task'

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
      require_relative "parsers/#{parse_name(parser)}"
      klass = parse_class(parser)
      klass.include self
      klass.attr_reader(:config)
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

  def runner
    @@runner ||= Runner.new
  end

  def start
    runner << begin
      Task.new(
        parser: self.class,
        method: config.dig(:start, :method),
        url:    config.dig(:start, :url),
        data:   {}
      )
    end

    loop do
      runner.execute
      runner.join
    end
  end

  def task(args)
    runner << (Task.new args)
  end

  def request(*args)
    url, = args
    Parsers.remote_request(url)
  end
end
