# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create items
green_tea_item = Item.create!(name: 'Green Tea')
strawberry_item = Item.create!(name: 'Green Tea')  # Note: Same name as in spec context
coffee_item = Item.create!(name: 'Green Tea')      # Note: Same name as in spec context
croissant_item = Item.create!(name: 'Croissant')

# Create products
green_tea = Product.create!(code: 'GR1', name: 'Regular Green Tea', price_micros: 3_110_000)
strawberry = Product.create!(code: 'SR1', name: 'Regular Strawberry', price_micros: 5_000_000)
coffee = Product.create!(code: 'CF1', name: 'Regular Coffee', price_micros: 11_230_000)

# Create product items (linking items to products)
ProductItem.create!(item: green_tea_item, product: green_tea)
ProductItem.create!(item: strawberry_item, product: strawberry)
ProductItem.create!(item: coffee_item, product: coffee)

# Create pricing rules
green_tea_buy_1_get_1 = ProductPricingRule.create!(name: 'GR1-BUY1-GET1')
strawberry_buy_3_discount = ProductPricingRule.create!(name: 'SR1-BUY3-DISCOUNT')
coffee_buy_3_discount = ProductPricingRule.create!(name: 'CF1-BUY3-DISCOUNT')
buy_1_sr1_buy_1_cf1_and_get_50off_on_gr1 = ProductPricingRule.create!(name: 'Buy 1 SR1 and 1 CF1, get 50% on GR1')

# Create pricing rule required products
PricingRuleRequiredProduct.create!(
  product_pricing_rule: green_tea_buy_1_get_1,
  product: green_tea,
  required_count: 1
)

PricingRuleRequiredProduct.create!(
  product_pricing_rule: strawberry_buy_3_discount,
  product: strawberry,
  required_count: 3
)

PricingRuleRequiredProduct.create!(
  product_pricing_rule: coffee_buy_3_discount,
  product: coffee,
  required_count: 3
)

PricingRuleRequiredProduct.create!(
  product_pricing_rule: buy_1_sr1_buy_1_cf1_and_get_50off_on_gr1,
  product: strawberry,
  required_count: 1
)

PricingRuleRequiredProduct.create!(
  product_pricing_rule: buy_1_sr1_buy_1_cf1_and_get_50off_on_gr1,
  product: coffee,
  required_count: 1
)

# Create pricing rule discountable products
PricingRuleDiscountableProduct.create!(
  product_pricing_rule: green_tea_buy_1_get_1,
  product: green_tea,
  discounted_price_micros: 0,
  limit: 1,
  offset: 1
)

PricingRuleDiscountableProduct.create!(
  product_pricing_rule: strawberry_buy_3_discount,
  product: strawberry,
  discounted_price_micros: 4_500_000,
  limit: nil,
  offset: nil
)

PricingRuleDiscountableProduct.create!(
  product_pricing_rule: coffee_buy_3_discount,
  product: coffee,
  discounted_price_micros: (coffee.price_micros * 2) / 3,
  limit: nil,
  offset: nil
)

PricingRuleDiscountableProduct.create!(
  product_pricing_rule: buy_1_sr1_buy_1_cf1_and_get_50off_on_gr1,
  product: green_tea,
  discounted_price_micros: green_tea.price_micros * 0.5,
  limit: 1,
  offset: nil
)
