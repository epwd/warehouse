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

ActiveRecord::Schema.define(version: 2021_08_23_001340) do

  create_table "deliveries", force: :cascade do |t|
    t.datetime "date_time"
    t.integer "product_id", null: false
    t.integer "sklad_id", null: false
    t.integer "quantify"
    t.string "aasm_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "consignment"
    t.index ["product_id"], name: "index_deliveries_on_product_id"
    t.index ["sklad_id"], name: "index_deliveries_on_sklad_id"
  end

  create_table "history_deliveries", force: :cascade do |t|
    t.text "delivered"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "history_transfers", force: :cascade do |t|
    t.bigint "src"
    t.bigint "dst"
    t.text "transferred"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_products_on_name", unique: true
  end

  create_table "regions", force: :cascade do |t|
    t.string "city"
    t.string "name"
    t.string "district"
    t.float "lat"
    t.float "lng"
  end

  create_table "sklad_products", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "sklad_id", null: false
    t.integer "quantify"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "delivery_last"
    t.index ["product_id"], name: "index_sklad_products_on_product_id"
    t.index ["sklad_id"], name: "index_sklad_products_on_sklad_id"
  end

  create_table "sklads", force: :cascade do |t|
    t.string "name"
    t.datetime "delivery_last"
    t.string "region"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_sklads_on_name", unique: true
    t.index ["region"], name: "index_sklads_on_region"
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "product_id"
    t.integer "src_sklad"
    t.integer "dst_sklad"
    t.integer "quantify"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "aasm_state"
    t.text "products"
    t.index ["product_id"], name: "index_transfers_on_product_id"
  end

  add_foreign_key "deliveries", "products"
  add_foreign_key "deliveries", "sklads"
  add_foreign_key "sklad_products", "products"
  add_foreign_key "sklad_products", "sklads"
  add_foreign_key "transfers", "products"
end
