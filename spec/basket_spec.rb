require 'spec_helper'
require_relative '../lib/product'
require_relative '../lib/basket'
require_relative '../lib/offers/each_nth_product_discount'
require_relative '../lib/deliveries/calculator'
require_relative '../lib/deliveries/rule'

describe Basket do
  subject(:basket) { described_class.new(catalog:, delivery_calculator:, offers:) }

  let(:catalog) do
    [
      Product.new(code: 'R01', price: 3295),
      Product.new(code: 'G01', price: 2495),
      Product.new(code: 'B01', price: 795)
    ]
  end

  let(:delivery_calculator) do
    Deliveries::Calculator.new(rules: delivery_rules)
  end

  let(:delivery_rules) do
    [
      Deliveries::Rule.new(required_amount: 0, price: 495),
      Deliveries::Rule.new(required_amount: 5000, price: 295),
      Deliveries::Rule.new(required_amount: 9000, price: 0)
    ]
  end

  let(:offers) do
    [
      Offers::EachNthProductDiscount.new(product_code: 'R01', per_product: 2, discount_percents: 50)
    ]
  end

  describe '#add_product' do
    it 'returns the product list with added product' do
      expect(basket.add_product('R01')).to eq([catalog[0]])
      expect(basket.add_product('G01')).to eq([catalog[0], catalog[1]])
      expect(basket.add_product('B01')).to eq([catalog[0], catalog[1], catalog[2]])
    end

    context 'when product code not found' do
      it 'raises an ArgumentError' do
        expect { basket.add_product('CC1') }.to raise_error(ArgumentError, 'Product not found')
      end
    end
  end

  describe '#total_price' do
    [
      [['B01', 'G01'], 3785],
      [['R01', 'R01'], 5437],
      [['R01', 'G01'], 6085],
      [['B01', 'B01', 'R01', 'R01', 'R01'], 9827]
    ].each do |product_codes, expected_price|
      context "when product codes are #{product_codes.join(', ')}" do
        before do
          product_codes.each { |code| basket.add_product(code) }
        end

        it "returns the total price of #{expected_price}" do
          expect(basket.total_price).to eq(expected_price)
        end
      end
    end
  end
end
