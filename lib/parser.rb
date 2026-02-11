class Parser
  LINE_FORMAT = /\A(\d+)\s+(.+)\s+at\s+(\d+\.\d{2})\z/.freeze

  class ParseError < StandardError; end

  def self.parse(line)
    match = line.strip.match(LINE_FORMAT)
    raise ParseError, "Invalid input line: '#{line}'" unless match

    amount = match[1]
    product = match[2]
    price = match[3]

    imported_match = product.match(/\A(imported\s+)?(.+)\z/)
    imported = !imported_match[1].nil?
    item_name = imported_match[2]

    { amount:, imported:, price:, product: item_name }
  end
end