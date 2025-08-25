class ProductPricingRule < ApplicationRecord
  has_many :pricing_rule_required_products
  has_many :pricing_rule_discountable_products

  after_save :set_total_discount

  def denormalized
    self.attributes.
      merge(requirement: self.pricing_rule_required_products.map(&:attributes)).
      merge(discountable: self.pricing_rule_discountable_products.map(&:attributes))
  end

  private

    def set_total_discount
      self.total_discount_micros = self.pricing_rule_discountable_products.includes(:product).inject(0) do |total, dp|
        total += (dp.product.price_micros - dp.discounted_price_micros)
      end
    end
end
