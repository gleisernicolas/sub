require 'spec_helper'
require_relative '../lib/receipt'
require_relative '../lib/purchase'

describe Receipt do
  it 'presents a formatted receipt with line items, sales taxes, and total' do
    purchase = Purchase.new([
      '1 book at 5.00',
      '2 imported box of chocolate at 10.00'
    ])

    receipt = Receipt.new(purchase)
    expected = [
      "1 book: 5.00",
      "2 imported box of chocolate: 21.00",
      "Sales Taxes: 1.00",
      "Total: 26.00"
    ].join("\n")

    expect(receipt.present).to eq(expected)
  end

  context 'official challenge outputs' do
    it 'matches expected output 1' do
      purchase = Purchase.new([
        '2 book at 12.49',
        '1 music CD at 14.99',
        '1 chocolate bar at 0.85'
      ])

      expected = [
        "2 book: 24.98",
        "1 music CD: 16.49",
        "1 chocolate bar: 0.85",
        "Sales Taxes: 1.50",
        "Total: 42.32"
      ].join("\n")

      expect(Receipt.new(purchase).present).to eq(expected)
    end

    it 'matches expected output 2' do
      purchase = Purchase.new([
        '1 imported box of chocolates at 10.00',
        '1 imported bottle of perfume at 47.50'
      ])

      expected = [
        "1 imported box of chocolates: 10.50",
        "1 imported bottle of perfume: 54.65",
        "Sales Taxes: 7.65",
        "Total: 65.15"
      ].join("\n")

      expect(Receipt.new(purchase).present).to eq(expected)
    end

    it 'matches expected output 3' do
      purchase = Purchase.new([
        '1 imported bottle of perfume at 27.99',
        '1 bottle of perfume at 18.99',
        '1 packet of headache pills at 9.75',
        '3 imported boxes of chocolates at 11.25'
      ])

      expected = [
        "1 imported bottle of perfume: 32.19",
        "1 bottle of perfume: 20.89",
        "1 packet of headache pills: 9.75",
        "3 imported boxes of chocolates: 35.55",
        "Sales Taxes: 7.90",
        "Total: 98.38"
      ].join("\n")

      expect(Receipt.new(purchase).present).to eq(expected)
    end
  end
end