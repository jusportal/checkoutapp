require 'rails_helper'

RSpec.describe CalculateCartOrdersPricing do
  include_context 'product context'

  let(:cart) { create(:cart) }
  subject { described_class.new(cart) }

  let!(:rules) do
    green_tea_buy_1_get_1
    strawberry_buy_3_discount
    coffee_buy_3_discount
  end

  # This is testing to demonstrate
  describe '#persist' do
    context 'buy 1 take 1 green tea' do
      let!(:orders) do
        orders = [
          "GR1",
          "SR1",
          "GR1",
          "GR1",
          "CF1",
        ].map do |product_code|
          product = Product.find_by(code: product_code)
          create(:order,
            cart: cart,
            product: product,
            price_micros: product.price_micros
          )
        end

        Order.where(id: orders.pluck(:id))
      end

      it 'computes discounted total price' do
        subject.persist
        expect(orders.reload.sum(:price_micros)).to eq(22_450_000)
      end
    end

    context 'buy 1 take 1 green tea, example 2' do
      let!(:orders) do
        orders = [
          "GR1",
          "GR1",
        ].map do |product_code|
          product = Product.find_by(code: product_code)
          create(:order,
            cart: cart,
            product: product,
            price_micros: product.price_micros
          )
        end

        Order.where(id: orders.pluck(:id))
      end

      it 'computes discounted total price' do
        subject.persist
        expect(orders.reload.sum(:price_micros)).to eq(3_110_000)
      end
    end

    context 'buy 3 then get 3 discounted price' do
      let!(:orders) do
        orders = [
          "SR1",
          "SR1",
          "GR1",
          "SR1"
        ].map do |product_code|
          product = Product.find_by(code: product_code)
          create(:order,
            cart: cart,
            product: product,
            price_micros: product.price_micros
          )
        end

        Order.where(id: orders.pluck(:id))
      end

      it 'computes discounted total price' do
        subject.persist
        expect(orders.reload.sum(:price_micros)).to eq(16_610_000)
      end
    end

    context 'buy 3 then get 2/3 of regular price' do
      let!(:orders) do
        orders = [
          "GR1",
          "CF1",
          "SR1",
          "CF1",
          "CF1"
        ].map do |product_code|
          product = Product.find_by(code: product_code)
          create(:order,
            cart: cart,
            product: product,
            price_micros: product.price_micros
          )
        end

        Order.where(id: orders.pluck(:id))
      end

      it 'computes discounted total price' do
        subject.persist
        expect(orders.reload.sum(:price_micros)).to eq(30_569_998)
      end
    end
  end
end
