require 'spec_helper'
require_relative '../lib/parser'

RSpec.describe Parser do
  it 'parses a simple non-imported product' do
    result = Parser.parse('1 book at 12.49')

    expect(result[:amount]).to eq("1")
    expect(result[:product]).to eq('book')
    expect(result[:price]).to eq("12.49")
    expect(result[:imported]).to eq(false)
  end

  it 'parses an imported product' do
    result = Parser.parse('1 imported book at 10.00')

    expect(result[:amount]).to eq("1")
    expect(result[:product]).to eq('book')
    expect(result[:price]).to eq("10.00")
    expect(result[:imported]).to eq(true)
  end

  it 'parses a quantity greater than 1' do
    result = Parser.parse('3 imported boxes of chocolates at 11.25')

    expect(result[:amount]).to eq("3")
    expect(result[:product]).to eq('boxes of chocolates')
    expect(result[:price]).to eq("11.25")
    expect(result[:imported]).to eq(true)
  end

  it 'parses a multi-word non-imported product' do
    result = Parser.parse('1 music CD at 14.99')

    expect(result[:amount]).to eq("1")
    expect(result[:product]).to eq('music CD')
    expect(result[:price]).to eq("14.99")
    expect(result[:imported]).to eq(false)
  end

  it 'parses a product with presentation and "of" pattern' do
    result = Parser.parse('1 packet of headache pills at 9.75')

    expect(result[:amount]).to eq("1")
    expect(result[:product]).to eq('packet of headache pills')
    expect(result[:price]).to eq("9.75")
    expect(result[:imported]).to eq(false)
  end

  context 'with invalid input' do
    it 'raises ParseError for a line missing price' do
      expect { Parser.parse('1 book') }.to raise_error(Parser::ParseError)
    end

    it 'raises ParseError for an empty line' do
      expect { Parser.parse('') }.to raise_error(Parser::ParseError)
    end

    it 'raises ParseError for a line with non-numeric quantity' do
      expect { Parser.parse('abc book at 10.00') }.to raise_error(Parser::ParseError)
    end

    it 'raises ParseError for a line with malformed price' do
      expect { Parser.parse('1 book at ten') }.to raise_error(Parser::ParseError)
    end
  end
end