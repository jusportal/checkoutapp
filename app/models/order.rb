class Order < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  scope :undiscounted, -> { where(denormalized_product_pricing_rule: nil) }
  scope :order_by_promo_name, -> do 
    order(Arel.sql("denormalized_product_pricing_rule->>'id'")).
    order(:created_at).
    order(price_micros: :desc)
  end

  def promo_name
    self.denormalized_product_pricing_rule&.send(:[], 'name')
  end
end
