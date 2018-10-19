require_relative 'app'

report = Parsers::DNSParser.new
report.start_parser
