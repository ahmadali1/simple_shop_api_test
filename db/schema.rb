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

ActiveRecord::Schema.define(version: 2021_12_26_125308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.integer "status", default: 0
    t.text "shipping_address"
    t.decimal "price", precision: 20, scale: 2
    t.datetime "paid_at"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "image_url"
    t.decimal "price", precision: 20, scale: 2
    t.string "sku"
    t.integer "stock"
    t.bigint "region_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["region_id"], name: "index_products_on_region_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "title", null: false
    t.string "country", null: false
    t.string "currency", null: false
    t.float "tax"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title", "user_id"], name: "index_regions_on_title_and_user_id", unique: true
    t.index ["user_id"], name: "index_regions_on_user_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "region_id", null: false
    t.index ["name", "user_id"], name: "index_stores_on_name_and_user_id", unique: true
    t.index ["region_id"], name: "index_stores_on_region_id"
    t.index ["user_id"], name: "index_stores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "orders", "users"
  add_foreign_key "products", "regions"
  add_foreign_key "regions", "users"
  add_foreign_key "stores", "regions"
  add_foreign_key "stores", "users"
end
