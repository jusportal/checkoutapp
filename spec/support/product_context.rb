RSpec.shared_context 'product context' do
  let(:green_tea_item) { create(:item, name: 'Green Tea') }
  let(:strawberry_item) { create(:item, name: 'Green Tea') }
  let(:coffee_item) { create(:item, name: 'Green Tea') }
  let(:croissant) { create(:item, name: 'Croissant') }

  let(:green_tea) do
    product_item = create(:product_item,
      item: green_tea_item,
      product: create(:product, code: 'GR1', name: 'Regular Green Tea', price_micros: 3_110_000)
    )

    product_item.product
  end

  let(:strawberry) do
    product_item = create(:product_item,
      item: strawberry_item,
      product: create(:product, code: 'SR1', name: 'Regular Strawberry', price_micros: 5_000_000)
    )

    product_item.product
  end

  let(:coffee) do
    product_item = create(:product_item,
      item: coffee_item,
      product: create(:product, code: 'CF1', name: 'Regular Coffee',  price_micros: 11_230_000)
    )

    product_item.product
  end

  let(:green_tea_buy_1_get_1) do
    rule = create(:product_pricing_rule, name: 'GR1-BUY1-GET1')
    create(:pricing_rule_required_product,
      product_pricing_rule: rule,
      product: green_tea,
      required_count: 1
    )

    create(:pricing_rule_discountable_product,
      product_pricing_rule: rule,
      product: green_tea,
      discounted_price_micros: 0,
      limit: 1,
      offset: 1
    )

    rule
  end

  let(:strawberry_buy_3_discount) do
    rule = create(:product_pricing_rule, name: 'SR1-BUY3-DISCOUNT')
    create(:pricing_rule_required_product,
      product_pricing_rule: rule,
      product: strawberry,
      required_count: 3
    )

    create(:pricing_rule_discountable_product,
      product_pricing_rule: rule,
      product: strawberry,
      discounted_price_micros: 4_500_000,
      limit: nil,
      offset: nil
    )

    rule
  end

  let(:coffee_buy_3_discount) do
    rule = create(:product_pricing_rule, name: 'CF1-BUY3-DISCOUNT')
    create(:pricing_rule_required_product,
      product_pricing_rule: rule,
      product: coffee,
      required_count: 3
    )

    create(:pricing_rule_discountable_product,
      product_pricing_rule: rule,
      product: coffee,
      discounted_price_micros: (coffee.price_micros * 2 ) / 3,
      limit: nil,
      offset: nil
    )

    rule
  end

  let(:buy_1_sr1_buy_1_cf1_and_get_50off_on_gr1) do
    rule = create(:product_pricing_rule, name: 'Buy 1 SR1 and 1 CF1, get 50% on GR1')
    create(:pricing_rule_required_product,
      product_pricing_rule: rule,
      product: strawberry,
      required_count: 1
    )

    create(:pricing_rule_required_product,
      product_pricing_rule: rule,
      product: coffee,
      required_count: 1
    )

    create(:pricing_rule_discountable_product,
      product_pricing_rule: rule,
      product: green_tea,
      discounted_price_micros: green_tea.price_micros * 0.5,
      limit: 1,
      offset: nil
    )

    rule
  end
end