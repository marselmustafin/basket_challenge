require 'spec_helper'
require_relative '../../lib/deliveries/calculator'
require_relative '../../lib/deliveries/rule'

describe Deliveries::Calculator do
  subject(:calculator) { described_class.new(rules: rules) }

  let(:rules) do
    [
      Deliveries::Rule.new(required_amount: 0, price: 15),
      Deliveries::Rule.new(required_amount: 100, price: 0)
    ]
  end

  context 'when no rules are provided' do
    let(:rules) { [] }

    it 'raises an ArgumentError' do
      expect { calculator }.to raise_error(ArgumentError, 'Rule with minimal price required')
    end
  end

  describe '#calculate_for' do
    subject(:calculate) { calculator.calculate_for(total_price) }

    context 'when total price is equal to the minimum required amount' do
      let(:total_price) { 0 }

      it { is_expected.to eq(15) }
    end

    context 'when total price is greater than the minimum required amount' do
      let(:total_price) { 50 }

      it { is_expected.to eq(15) }
    end

    context 'when total price exceeds all rules' do
      let(:total_price) { 250 }

      it { is_expected.to eq(0) }
    end
  end
end
