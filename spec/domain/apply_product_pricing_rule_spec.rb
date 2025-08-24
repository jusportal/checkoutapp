require 'rails_helper'

RSpec.describe ApplyProductPricingRule do
  include_context 'product context'

  let(:cart) { create(:cart) }
  let!(:orders) do
    orders = [
      green_tea,
      green_tea,
      green_tea,
      strawberry,
      strawberry,
      strawberry,
      strawberry,
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

  subject { described_class.new(rule, orders) }

  describe '#persist' do
    before do
      rule.pricing_rule_discountable_products.each do |disc_product|
        disc_product.update(limit: limit, offset: offset)
      end

      subject.persist
    end

    context 'buy number of specific products and ALL orders of a specific product will be discounted' do
      let(:rule) { buy_1_sr1_buy_1_cf1_and_get_50off_on_gr1 }

      context 'discount on limited number of orders' do
        let(:limit) { 1 }
        let(:offset) { nil }

        it 'updates the price of 1 discountable order' do
          expected_prices = [
            (green_tea.price_micros * 0.5).to_i,
            green_tea.price_micros,
            green_tea.price_micros
          ]

          expect(orders.reload.where(product_id: green_tea.id).pluck(:price_micros)).to match_array(expected_prices)
        end
      end

      context 'discount unlimited number of orders' do
        let(:limit) { nil }
        let(:offset) { nil }

        it 'updates the price of the discountable orders' do
          discounted_product_price = (green_tea.price_micros * 0.5).to_i
          expected_prices = Array.new(3) { discounted_product_price }

          expect(orders.where(product_id: green_tea.id).pluck(:price_micros)).to match_array(expected_prices)
        end
      end
    end

    context 'buy number of specific products and ONLY NEXT orders of a specific product will be discounted' do
      let(:rule) { strawberry_buy_3_discount }

      context 'discount on limited number of orders' do
        let(:limit) { 1 }
        let(:offset) { 1 }

        it 'updates the price of 1 discountable order' do
          expected_prices = [
            rule.pricing_rule_discountable_products.first.discounted_price_micros.to_i,
            strawberry.price_micros,
            strawberry.price_micros,
            strawberry.price_micros,
            strawberry.price_micros
          ]

          expect(orders.where(product_id: strawberry.id).pluck(:price_micros)).to match_array(expected_prices)
        end
      end

      context 'discount unlimited number of orders' do
        let(:limit) { nil }
        let(:offset) { 1 }

        it 'updates the price of 1 discountable order' do
          discounted_product_price = rule.pricing_rule_discountable_products.first.discounted_price_micros
          expected_prices = [
            discounted_product_price,
            discounted_product_price,
            discounted_product_price,
            discounted_product_price,
            strawberry.price_micros
          ]

          expect(orders.where(product_id: strawberry.id).pluck(:price_micros)).to match_array(expected_prices)
        end
      end
    end
  end
end
