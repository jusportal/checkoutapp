class CreateProductPricingRules < ActiveRecord::Migration[8.0]
  def change
    create_table :product_pricing_rules do |t|
      t.string :name

      t.timestamps
    end
  end
end
