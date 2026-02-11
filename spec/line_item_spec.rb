require 'spec_helper'
require_relative '../lib/line_item'

RSpec.describe LineItem do
  it 'should create a line item' do
    line_item = LineItem.new(amount: 3, product: 'book', price: 10.00, imported: false)
    
    expect(line_item.amount).to eq(3)
    expect(line_item.product).to be_a_instance_of(Product)
    expect(line_item.total).to eq(30.00)
    expect(line_item.imported?).to eq(false)
    expect(line_item.product_name).to eq('book')
    expect(line_item.display_name).to eq('book')
  end

  it 'includes imported prefix in display_name for imported items' do
    line_item = LineItem.new(amount: 1, product: 'box of chocolates', price: 10.00, imported: true)

    expect(line_item.display_name).to eq('imported box of chocolates')
  end
end