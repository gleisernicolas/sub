require_relative 'parser'
require_relative 'line_item'

class Purchase
  attr_reader :line_items
  
  def initialize(lines)
    @line_items = lines.map do |line|
      line_item_hash = Parser.parse(line)
    
      LineItem.new(**line_item_hash)
    end
  end
end