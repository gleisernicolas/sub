require 'spec_helper'
require_relative '../../lib/services/product_categorization_service'

RSpec.describe ProductCategorizationService do
  describe '.category' do
    it 'returns food for food products' do
      expect(ProductCategorizationService.category('chocolate')).to eq('food')
      expect(ProductCategorizationService.category('chocolate bar')).to eq('food')
      expect(ProductCategorizationService.category('imported box of chocolates')).to eq('food')
    end

    it 'returns medicine for medicine products' do
      expect(ProductCategorizationService.category('headache pill')).to eq('medicine')
      expect(ProductCategorizationService.category('bottle of headache pills')).to eq('medicine')
      expect(ProductCategorizationService.category('imported headache pill')).to eq('medicine')
    end

    it 'returns book for books' do
      expect(ProductCategorizationService.category('book')).to eq('book')
      expect(ProductCategorizationService.category('imported book')).to eq('book')
    end

    it 'returns others for uncategorized products' do
      expect(ProductCategorizationService.category('music CD')).to eq('others')
    end
  end

  describe '.extract_presentation' do
    it 'extracts presentation from "<product> <presentation>" pattern' do
      expect(ProductCategorizationService.extract_presentation('chocolate bar')).to eq('bar')
    end

    it 'extracts presentation from "<presentation> of <product>" pattern' do
      expect(ProductCategorizationService.extract_presentation('bottle of headache pills')).to eq('bottle')
      expect(ProductCategorizationService.extract_presentation('box of chocolates')).to eq('box')
      expect(ProductCategorizationService.extract_presentation('packet of rice')).to eq('packet')
    end

    it 'handles imported products' do
      expect(ProductCategorizationService.extract_presentation('imported chocolate bar')).to eq('bar')
      expect(ProductCategorizationService.extract_presentation('imported box of chocolates')).to eq('box')
    end

    it 'returns nil when there is no presentation' do
      expect(ProductCategorizationService.extract_presentation('book')).to be_nil
      expect(ProductCategorizationService.extract_presentation('music CD')).to be_nil
    end
  end
end