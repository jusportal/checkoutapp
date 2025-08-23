class CreatePricingRuleRequiredProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :pricing_rule_required_products do |t|
      t.references :product_pricing_rule, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :required_count

      t.timestamps
    end
  end
end
