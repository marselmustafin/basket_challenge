class Basket
  attr_reader :products, :catalog, :offers, :delivery_rules

  def initialize(delivery_rules:, catalog: [], offers: [])
    @products = []

    @catalog = catalog
    @offers = offers
    @delivery_rules = delivery_rules
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

    [total, 0].max
  end

  private

  def offers_discount(products)
    offers.map { |offer| offer.discount_for(products) }.sum
  end

  def delivery_charge(total)
  end
end
