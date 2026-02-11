require_relative "product"

class LineItem
  attr_reader :amount, :product, :total

  def initialize(amount:, product:, price:, imported:)
    @amount = amount.to_i
    @product = Product.new(product, price.to_f, imported)
    @total = @amount * @product.price
  end

  def imported?
    @product.imported
  end

  def product_name
    @product.name
  end

  def display_name
    imported? ? "imported #{product_name}" : product_name
  end
end