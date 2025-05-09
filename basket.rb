class Basket
  private attr_reader :products
  attr_reader :product_catalog

  def initialize(product_catalog)
    @product_catalog = []
    @products = []
  end

  def add_product(product_code)
    product = product_catalog.find { |p| p.code == product_code }

    raise "Product not found" unless product

    products << product
  end

  def total_price
    total = 0

    return total if products.empty?

    total = products.sum(&:price)
    total = total - offers_discount(products)
    total = total + delivery_charge(total)

    total
  end

  private

  def offers_discount(products)
  end

  def delivery_charge(total)
  end
end
