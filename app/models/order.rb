class Order < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  scope :undiscounted, -> { where(denormalized_product_pricing_rule: nil) }
end
