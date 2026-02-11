require 'spec_helper'
require_relative '../lib/product'

RSpec.describe Product do
  it 'should create a product' do
    product = Product.new('book', 10.00, false)
    expect(product.name).to eq('book')
    expect(product.price).to eq(10.00)
    expect(product.imported).to eq(false)
  end
end