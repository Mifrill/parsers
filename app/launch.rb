require_relative 'parser'

parser_name = ARGV.shift
abort 'specify the parser name (for example: Test)' unless parser_name

Parser.build(parser_name).new
