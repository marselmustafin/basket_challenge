class Basket
  attr_reader :products, :catalog, :offers, :delivery_calculator

  def initialize(catalog:, delivery_calculator:, offers: [])
    @products = []

    @catalog = catalog
    @offers = offers
    @delivery_calculator = delivery_calculator
  end

  def add_product(product_code)
    product = catalog.find { |p| p.code == product_code }

    raise ArgumentError, 'Product not found' unless product

    products << product
  end

  def total_price
    return 0 if products.empty?

    total = products.sum(&:price)
    total -= offers_discount(products)
    total += delivery_charge(total)

    [total, 0].max
  end

  private

  def offers_discount(products)
    offers.map { |offer| offer.discount_for(products) }.sum
  end

  def delivery_charge(total)
    delivery_calculator.calculate_for(total)
  end
end
