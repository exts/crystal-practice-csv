require "./csv/reader"

include Csv

filename = "example.csv"
reader = Reader.new filename
reader.read_and_parse()

puts reader.parsed_data