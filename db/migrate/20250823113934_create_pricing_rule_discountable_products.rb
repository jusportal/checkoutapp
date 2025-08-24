class CreatePricingRuleDiscountableProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :pricing_rule_discountable_products do |t|
      t.references :product_pricing_rule, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.decimal :percentage_discount
      t.integer :discounted_price_micros
      t.integer :limit
      t.integer :offset

      t.timestamps
    end
  end
end
