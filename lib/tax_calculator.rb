require_relative './services/product_categorization_service'

class TaxCalculator
  EXEMPT_CATEGORY = %w[food medicine book].freeze

  def self.perform(unit_price, product_name, imported)
    rate = 0

    product_category = ProductCategorizationService.category(product_name)
    rate += 10 unless EXEMPT_CATEGORY.include?(product_category)
    rate += 5 if imported

    tax = round_up_to_nearest_005(unit_price * rate / 100.0)
    (unit_price + tax).round(2)
  end

  def self.round_up_to_nearest_005(amount)
    (amount * 20.0).ceil / 20.0
  end

end