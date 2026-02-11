class Product
  attr_reader :name, :price, :imported

  def initialize(name, price, imported)
    @name = name
    @price = price
    @imported = imported
  end
end