require 'spec_helper'
require_relative '../lib/tax_calculator'

RSpec.describe TaxCalculator do
  describe '.perform' do
    context 'when the product is exempt' do
      it 'should return the total with no tax' do
        expect(TaxCalculator.perform(10.00, 'book', false)).to eq(10.00)
        expect(TaxCalculator.perform(10.00, 'chocolate', false)).to eq(10.00)
        expect(TaxCalculator.perform(10.00, 'headache pill', false)).to eq(10.00)
      end

      context 'when the product is imported' do
        it 'should return the total with 5% tax' do
          expect(TaxCalculator.perform(10.00, 'imported book', true)).to eq(10.50)
          expect(TaxCalculator.perform(10.00, 'imported chocolate', true)).to eq(10.50)
          expect(TaxCalculator.perform(10.00, 'imported headache pill', true)).to eq(10.50)
        end
      end
    end
    
    context 'when the product is not exempt' do
      it 'applies 10% basic sales tax' do
        expect(TaxCalculator.perform(10.00, 'music CD', false)).to eq(11.00)
        expect(TaxCalculator.perform(10.00, 'perfume', false)).to eq(11.00)
      end

      context 'when the product is also imported' do
        it 'applies 10% basic + 5% import duty' do
          expect(TaxCalculator.perform(10.00, 'imported music CD', true)).to eq(11.50)
          expect(TaxCalculator.perform(10.00, 'imported perfume', true)).to eq(11.50)
        end
      end
    end

    context 'rounding up to nearest 0.05' do
      it 'rounds 10% tax on 14.99 up to 1.50' do
        # 14.99 * 0.10 = 1.499 → rounds up to 1.50
        expect(TaxCalculator.perform(14.99, 'music CD', false)).to eq(16.49)
      end

      it 'rounds 15% tax on 47.50 up to 7.15' do
        # 47.50 * 0.15 = 7.125 → rounds up to 7.15
        expect(TaxCalculator.perform(47.50, 'imported perfume', true)).to eq(54.65)
      end

      it 'rounds 5% import duty on 11.25 up to 0.60' do
        # 11.25 * 0.05 = 0.5625 → rounds up to 0.60
        expect(TaxCalculator.perform(11.25, 'imported chocolates', true)).to eq(11.85)
      end

      it 'rounds 10% tax on 18.99 up to 1.90' do
        # 18.99 * 0.10 = 1.899 → rounds up to 1.90
        expect(TaxCalculator.perform(18.99, 'perfume', false)).to eq(20.89)
      end
    end
  end
end
