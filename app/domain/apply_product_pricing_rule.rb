class ApplyProductPricingRule
  attr_reader :product_pricing_rule,
    :orders

  def initialize(product_pricing_rule, orders)
    @product_pricing_rule = product_pricing_rule
    @orders = orders
  end

  def persist
    self.pricing_rule_discountable_products.each do |disc_product|
      self.apply_discount(disc_product)
    end

    self.pricing_rule_required_products.each do |req_product|
      self.mark_related_orders(req_product)
    end
  end

  protected

    def pricing_rule_discountable_products
      @pricing_rule_discountable_products ||= self.product_pricing_rule.
        pricing_rule_discountable_products
    end

    def pricing_rule_required_products
      @pricing_rule_required_products ||= self.product_pricing_rule.
        pricing_rule_required_products
    end

    def apply_discount(disc_product)
      discountable_orders = self.orders.undiscounted.
        where(product_id: disc_product.product_id).
        limit(disc_product.limit).
        offset(disc_product.offset)

      discountable_orders.each do |order|
        order.update(
          price_micros: disc_product.discounted_price_micros,
          denormalized_product_pricing_rule: {}
        )
      end
    end

    def mark_related_orders(req_product)
      related_orders = self.orders.undiscounted.
        where(product_id: req_product.product_id).
        limit(req_product.required_count)

      related_orders.each do |order|
        order.update(
          denormalized_product_pricing_rule: {}
        )
      end
    end
end
