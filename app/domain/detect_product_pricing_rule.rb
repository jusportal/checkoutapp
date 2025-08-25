class DetectProductPricingRule
  attr_reader :orders, :product_ids

  def initialize(orders)
    @orders = orders
    @product_ids = self.orders.pluck(:product_id)
  end

  def product_pricing_rule
    return nil if self.orders.empty?

    self.product_pricing_rules.select do |rule|
      self.detect(rule)
    end.sort_by(&:total_discount_micros).first
  end

  protected

    def product_pricing_rules
      @product_pricing_rules ||= ProductPricingRule.includes(:pricing_rule_required_products).to_a
    end

    def detect(product_pricing_rule)
      self.satisfied_required_orders?(product_pricing_rule) &&
      self.has_discountable_order?(product_pricing_rule)
    end

    def satisfied_required_orders?(product_pricing_rule)
      return false if self.orders.blank?

      product_pricing_rule.pricing_rule_required_products.all? do |required_product|
        self.product_ids.count(required_product.product_id) >= required_product.required_count
      end
    end

    def has_discountable_order?(product_pricing_rule)
      product_pricing_rule.pricing_rule_discountable_products.find do |disc_product|
        (self.product_ids.count(disc_product.product_id) - (disc_product.offset || 0)) > 0
      end
    end
end
