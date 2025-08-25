require 'rails_helper'

RSpec.describe DetectProductPricingRule do
  include_context 'product context'

  let(:cart) { create(:cart) }
  let!(:orders) do
    orders = [
      green_tea,
      green_tea,
      green_tea,
      strawberry,
      coffee
    ].map do |product|
      create(:order,
        cart: cart,
        product: product,
        price_micros: product.price_micros
      )
    end

    Order.where(id: orders.pluck(:id))
  end

  subject { described_class.new(orders) }

  describe '#product_pricing_rule' do
    context 'with no rule' do
      it 'detects no rule' do
        expect(subject.product_pricing_rule).to be_nil
      end
    end

    context 'with single rule' do
      let!(:rule1) { green_tea_buy_1_get_1 }

      it 'detects the rule' do
        expect(subject.product_pricing_rule).to eq rule1
      end
    end

    context 'with other rules' do
      let!(:rule1) { green_tea_buy_1_get_1 }
      let!(:rule2) { buy_1_sr1_buy_1_cf1_and_get_50off_on_gr1 }

      it 'detects the correct rule' do
        expect(subject.product_pricing_rule).to eq rule1
      end
    end

    context 'with not enough required orders' do
      before do
        green_tea_buy_1_get_1.pricing_rule_discountable_products.
          first.update(offset: 3)

        green_tea_buy_1_get_1.pricing_rule_required_products.
          first.update(required_count: 3)
      end

      it 'does not detect the rule' do
        expect(subject.product_pricing_rule).to be_nil
      end
    end
  end
end
