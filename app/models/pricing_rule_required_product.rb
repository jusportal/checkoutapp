class PricingRuleRequiredProduct < ApplicationRecord
  belongs_to :product_pricing_rule
  belongs_to :product
end
