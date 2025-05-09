module Deliveries
  class Calculator
    private attr_reader :rules

    def initialize(rules:)
      @rules = rules

      raise ArgumentError, "Rule with minimal price required" if rules.none? { |r| r.required_amount.zero? }
    end

    def calculate_for(total_price)
      rules.filter_map { |rule| rule.price_for(total_price) }.min
    end
  end
end
