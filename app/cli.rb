require_relative '../app/parser'

require 'thor'

module Parser
  class CLI < Thor
    desc 'start PARSER', 'build and run parser by class name'

    def start(parser)
      klass = Parser.build(parser)
      klass.new
    end
  end
end

Parser::CLI.start(ARGV)
