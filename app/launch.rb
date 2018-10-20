require_relative 'app'

parser_name = ARGV.shift
abort 'specify the parser name (for example: DNS)' unless parser_name

parser = Parsers.build_parser(parser_name)
parser.start
