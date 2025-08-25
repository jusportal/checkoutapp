class CalculateCartOrdersPricing
  attr_reader :cart, :orders

  def initialize(cart)
    @cart = cart
    @orders = self.cart.orders.includes(:product)
  end

  def persist
    self.orders.each do |order|
      order.update(
        denormalized_product_pricing_rule: nil,
        price_micros: order.product.price_micros
      )
    end

    current_product_pricing_rule = self.detect_product_pricing_rule(self.orders)
    undiscounted_orders = self.orders

    while current_product_pricing_rule.present?
      service = ApplyProductPricingRule.new(current_product_pricing_rule, undiscounted_orders)
      service.persist

      undiscounted_orders = self.orders.undiscounted.reload
      current_product_pricing_rule = self.detect_product_pricing_rule(undiscounted_orders)
    end

    true
  end

  protected

    def detect_product_pricing_rule(current_orders)
      service = DetectProductPricingRule.new(current_orders)
      service.product_pricing_rule
    end
end
