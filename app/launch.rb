require_relative 'app'

report = DNSParser::Parser.new
report.get_report
