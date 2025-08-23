class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :product, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
      t.integer :price_micros, null: false
      t.jsonb :denormalized_product_pricing_rule

      t.timestamps
    end
  end
end
