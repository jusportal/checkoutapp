FactoryBot.define do
  factory :item do
    name  { Faker::Tea.variety }
  end
end