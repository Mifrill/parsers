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
      klass.send :include, self
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

  def request(*args)
    url, = args
    Parsers.remote_request(url)
  end
end
