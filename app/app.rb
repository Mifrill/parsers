require_relative '../settings/capybara'
require_relative 'runner'

require 'rest-client'

module Parsers
  include Capybara::DSL

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

  def start
    @@runner = Runner.new
    queue   = Queue.new

    @@runner << begin
      { parser: self.class, method: self.config.dig(:start, :method), url: self.config.dig(:start, :url), data: {} }
    end

    threads = []

    loop do
      threads << Thread.new do
        @@runner.each do |task|
          visit(task[:url])

          task[:parser].new.send task[:method] do |result|
            queue << result.pop
          end
        end
      end

      threads << Thread.new do
        queue.pop
      end

      threads.map(&:join)

      break threads.empty?
    end
  end

  def task(args)
    @@runner << args
  end

  def request(*args)
    url, = args
    Parsers.remote_request(url)
  end
end
