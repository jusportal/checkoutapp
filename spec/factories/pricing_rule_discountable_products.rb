FactoryBot.define do
  factory :pricing_rule_discountable_product do
    product_pricing_rule { create(:product_pricing_rule) }
    product { create(:product) }
    percentage_discount { 0.3 }
    discounted_price_micros { 500_000 }
    limit { 0 }
    offset { 0 }
  end
end
