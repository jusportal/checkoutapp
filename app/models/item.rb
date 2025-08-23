class Item < ApplicationRecord
  has_many :product_items
  has_many :products, through: :product_items
end
