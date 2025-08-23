FactoryBot.define do
  factory :product do
    code { "TE1" }
    name  { Faker::Tea.variety }
    price_micros { 1_000_000 }
  end
end
