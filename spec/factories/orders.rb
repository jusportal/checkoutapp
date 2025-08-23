FactoryBot.define do
  factory :order do
    cart { create(:cart) }
    product  { create(:product) }
    price_micros { 1_000_000 }
    denormalized_product_pricing_rule { nil }
  end
end