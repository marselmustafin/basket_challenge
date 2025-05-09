module Deliveries
  class Rule
    attr_reader :required_amount, :price

    def initialize(required_amount:, price:)
      @required_amount = required_amount
      @price = price
    end

    def price_for(amount)
      return unless amount >= required_amount

      price
    end
  end
end
