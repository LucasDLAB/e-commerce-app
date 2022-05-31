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

ActiveRecord::Schema[7.0].define(version: 2022_05_30_230512) do
  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "estimated_dates", force: :cascade do |t|
    t.decimal "min_distance"
    t.decimal "max_distance"
    t.integer "business_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_company_id", null: false
    t.index ["shipping_company_id"], name: "index_estimated_dates_on_shipping_company_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "street"
    t.string "city"
    t.string "state"
    t.integer "number"
    t.decimal "weight"
    t.decimal "length"
    t.decimal "height"
    t.decimal "width"
    t.string "destinatary_name"
    t.string "destinatary_identification"
    t.integer "shipping_company_id"
    t.decimal "dimension"
    t.string "order_code"
    t.decimal "destinatary_distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "full_address"
    t.string "wanted_companies"
    t.integer "transport_vehicle_id"
    t.decimal "order_price"
    t.integer "estimated_date"
    t.string "collect_code"
    t.index ["shipping_company_id"], name: "index_orders_on_shipping_company_id"
    t.index ["transport_vehicle_id"], name: "index_orders_on_transport_vehicle_id"
  end

  create_table "shipping_companies", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "registration_number"
    t.string "email_domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "billing_address"
    t.string "street"
    t.string "city"
    t.integer "number"
    t.string "state"
    t.decimal "distance"
    t.decimal "min_price", default: "0.0"
    t.integer "status", default: 0
  end

  create_table "table_prices", force: :cascade do |t|
    t.decimal "minimum_weight"
    t.decimal "max_weight"
    t.decimal "minimum_dimension"
    t.decimal "max_dimension"
    t.decimal "max_height"
    t.decimal "minimum_height"
    t.decimal "max_width"
    t.decimal "minimum_width"
    t.decimal "max_length"
    t.decimal "minimum_length"
    t.integer "shipping_company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price"
    t.index ["shipping_company_id"], name: "index_table_prices_on_shipping_company_id"
  end

  create_table "transport_vehicles", force: :cascade do |t|
    t.string "brand"
    t.integer "year_manufacture"
    t.decimal "payload"
    t.string "vehicle_model"
    t.string "identification_plate"
    t.integer "shipping_company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "dimension"
    t.decimal "height"
    t.decimal "length"
    t.decimal "width"
    t.integer "status", default: 0
    t.index ["shipping_company_id"], name: "index_transport_vehicles_on_shipping_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_company_id", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["shipping_company_id"], name: "index_users_on_shipping_company_id"
  end

  add_foreign_key "estimated_dates", "shipping_companies"
  add_foreign_key "orders", "shipping_companies"
  add_foreign_key "orders", "transport_vehicles"
  add_foreign_key "table_prices", "shipping_companies"
  add_foreign_key "transport_vehicles", "shipping_companies"
  add_foreign_key "users", "shipping_companies"
end
