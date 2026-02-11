require_relative 'lib/purchase'
require_relative 'lib/receipt'
require_relative 'lib/parser'

filename = ARGV[0]

if filename.nil? || filename.empty?
  $stderr.puts "Usage: ruby main.rb <input_file>"
  exit 1
end

unless File.exist?(filename)
  $stderr.puts "Error: file not found '#{filename}'"
  exit 1
end

begin
  lines = File.readlines(filename).map(&:chomp).reject(&:empty?)
  receipt = Receipt.new(Purchase.new(lines))
  puts receipt.present
rescue Parser::ParseError => e
  $stderr.puts "Error: #{e.message}"
  exit 1
end