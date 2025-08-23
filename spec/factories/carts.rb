FactoryBot.define do
  factory :cart do
    customer_name  { Faker::Name.name }
  end
end
