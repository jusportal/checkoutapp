# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_23_114118) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "carts", force: :cascade do |t|
    t.string "customer_name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "cart_id", null: false
    t.integer "price_micros", null: false
    t.jsonb "denormalized_product_pricing_rule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_orders_on_cart_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
  end

  create_table "pricing_rule_discountable_products", force: :cascade do |t|
    t.bigint "product_pricing_rule_id", null: false
    t.bigint "product_id", null: false
    t.decimal "percentage_discount"
    t.integer "discounted_price_micros"
    t.integer "limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_pricing_rule_discountable_products_on_product_id"
    t.index ["product_pricing_rule_id"], name: "idx_on_product_pricing_rule_id_17ea73d4c4"
  end

  create_table "pricing_rule_required_products", force: :cascade do |t|
    t.bigint "product_pricing_rule_id", null: false
    t.bigint "product_id", null: false
    t.integer "required_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_pricing_rule_required_products_on_product_id"
    t.index ["product_pricing_rule_id"], name: "idx_on_product_pricing_rule_id_4dea301219"
  end

  create_table "product_items", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_product_items_on_item_id"
    t.index ["product_id"], name: "index_product_items_on_product_id"
  end

  create_table "product_pricing_rules", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.integer "price_micros"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "orders", "carts"
  add_foreign_key "orders", "products"
  add_foreign_key "pricing_rule_discountable_products", "product_pricing_rules"
  add_foreign_key "pricing_rule_discountable_products", "products"
  add_foreign_key "pricing_rule_required_products", "product_pricing_rules"
  add_foreign_key "pricing_rule_required_products", "products"
  add_foreign_key "product_items", "items"
  add_foreign_key "product_items", "products"
end
