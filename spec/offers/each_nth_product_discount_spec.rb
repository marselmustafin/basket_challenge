require 'spec_helper'
require_relative '../../lib/offers/each_nth_product_discount'
require_relative '../../lib/product'

describe Offers::EachNthProductDiscount do
  subject(:offer) { described_class.new(product_code:, discount_quantity:, discount_percents:) }
  
  let(:product_code) { "EW1" }
  let(:discount_quantity) { 2 }
  let(:discount_percents) { 50 }

  describe '#discount_for' do
    subject(:discount) { offer.discount_for(products) }

    let(:products) do
      [
        Product.new(name: "Coca Cola", code: "CC1", price: 200),
        Product.new(name: "Dr. Pepper", code: "DP1", price: 300),
      ] + [Product.new(name: "Evian Water", code: "EW1", price: 400)] * 7
    end

    context 'when each 2nd product has 50% discount' do
      it { is_expected.to eq(600) }
    end

    context 'when each 5th product is free' do
      let(:product_code) { "EW1" }
      let(:discount_quantity) { 5 }
      let(:discount_percents) { 100 }

      it { is_expected.to eq(400) }
    end

    context 'when product code is invalid' do
      let(:product_code) { "INVALID" }

      it { is_expected.to eq(0) }
    end

    context 'when there are no products' do
      let(:products) { [] }

      it { is_expected.to eq(0) }
    end
  end
end
