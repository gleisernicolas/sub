require 'spec_helper'
require_relative '../lib/purchase'

RSpec.describe Purchase do
  it 'should create a purchase' do
    lines = [
      '1 book at 5.00',
      '2 imported box of chocolate at 10.00'
    ]
    
    purchase = Purchase.new(lines)
    line_items = purchase.line_items
    
    expect(line_items.size).to eq(2)
    expect(line_items[0].amount).to eq(1)
    expect(line_items[0].product.name).to eq('book')
    expect(line_items[0].product.price).to eq(5.00)
    expect(line_items[0].product.imported).to eq(false)
    expect(line_items[0].total).to eq(5.00)
    expect(line_items[0].imported?).to eq(false)
    expect(line_items[0].product_name).to eq('book')

    expect(line_items[1].amount).to eq(2)
    expect(line_items[1].product.name).to eq('box of chocolate')
    expect(line_items[1].product.price).to eq(10.00)
    expect(line_items[1].product.imported).to eq(true)
    expect(line_items[1].total).to eq(20.00)
    expect(line_items[1].imported?).to eq(true)
    expect(line_items[1].product_name).to eq('box of chocolate')
  end
end