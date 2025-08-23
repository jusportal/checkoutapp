class CreateProductItems < ActiveRecord::Migration[8.0]
  def change
    create_table :product_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
