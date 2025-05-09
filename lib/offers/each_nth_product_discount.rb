module Offers
  class EachNthProductDiscount
    attr_reader :product_code, :per_product, :discount_percents

    def initialize(product_code:, per_product:, discount_percents:)
      @product_code = product_code
      @per_product = per_product
      @discount_percents = discount_percents
    end

    def discount_for(products)
      products = products.select { |p| p.code == product_code }

      return 0 if products.empty?

      product_price = products.first.price
      discountable_quantity = products.size / per_product

      (discountable_quantity * product_price * 0.01 * discount_percents).round
    end
  end
end
