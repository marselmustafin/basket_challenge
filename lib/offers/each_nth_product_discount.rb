module Offers
  class EachNthProductDiscount
    attr_reader :product_code, :discount_quantity, :discount_percents

    def initialize(product_code:, discount_quantity:, discount_percents:)
      @product_code = product_code
      @discount_quantity = discount_quantity
      @discount_percents = discount_percents
    end

    def discount_for(products)
      products = products.select { |p| p.code == product_code }

      return 0 if products.empty?

      product_price = products.first.price

      discountable_quantity = products.size / discount_quantity
      (discountable_quantity * product_price * (discount_percents * 0.01)).to_i
    end
  end
end
