class Cart < ApplicationRecord
  has_many :orders

  def recalculate
    service = CalculateCartOrdersPricing.new(self.reload)
    service.persist
  end
end
