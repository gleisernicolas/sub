require_relative 'tax_calculator'

class Receipt
  def initialize(purchase)
    @purchase = purchase
  end

  def present
    tax_total = 0
    total = 0
    lines = @purchase.line_items.map do |line_item|
      taxed_unit_price = TaxCalculator.perform(line_item.product.price, line_item.product_name, line_item.imported?)
      line_item_total = line_item.amount * taxed_unit_price
      line_item_tax = line_item_total - line_item.total

      tax_total += line_item_tax
      total += line_item_total

      "#{line_item.amount} #{line_item.display_name}: #{format('%.2f', line_item_total)}"
    end

    lines << "Sales Taxes: #{format('%.2f', tax_total)}"
    lines << "Total: #{format('%.2f', total)}"

    lines.join("\n")
  end
end