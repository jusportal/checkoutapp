class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.string :customer_name
      t.integer :status

      t.timestamps
    end
  end
end
