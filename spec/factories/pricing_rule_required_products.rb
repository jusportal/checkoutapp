FactoryBot.define do
  factory :pricing_rule_required_products do
    product_pricing_rule { create(:product_pricing_rule) }
    product { create(:product) }
    required_count: 3
  end
end
