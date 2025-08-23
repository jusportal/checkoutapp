FactoryBot.define do
  factory :product do
    product  { create(:product) }
    item { create(:item) }
  end
end
