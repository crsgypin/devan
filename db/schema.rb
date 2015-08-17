# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150817005459) do

  create_table "addresses", force: :cascade do |t|
    t.text     "address"
    t.integer  "city_id"
    t.integer  "district_id"
    t.string   "postal_code"
    t.integer  "address_link_id"
    t.string   "address_link_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.float    "lat"
    t.float    "lng"
  end

  add_index "addresses", ["city_id"], name: "index_addresses_on_city_id"
  add_index "addresses", ["district_id"], name: "index_addresses_on_district_id"

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customer_delivery_days", force: :cascade do |t|
    t.integer  "customer_id"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.boolean  "sunday"
    t.boolean  "unstable_day"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "customer_delivery_days", ["customer_id"], name: "index_customer_delivery_days_on_customer_id"

  create_table "customer_routes", force: :cascade do |t|
    t.integer  "delivery_person_id"
    t.string   "wday"
    t.integer  "customer_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "customer_routes", ["customer_id"], name: "index_customer_routes_on_customer_id"
  add_index "customer_routes", ["delivery_person_id"], name: "index_customer_routes_on_delivery_person_id"

  create_table "customers", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "daily_form_update_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "daily_form_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "daily_form_update_users", ["daily_form_id"], name: "index_daily_form_update_users_on_daily_form_id"
  add_index "daily_form_update_users", ["user_id"], name: "index_daily_form_update_users_on_user_id"

  create_table "daily_forms", force: :cascade do |t|
    t.integer  "manufacturer_id"
    t.date     "date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "daily_forms", ["manufacturer_id"], name: "index_daily_forms_on_manufacturer_id"

  create_table "delivery_people", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.string   "postal_code"
    t.integer  "order"
    t.integer  "city_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "districts", ["city_id"], name: "index_districts_on_city_id"

  create_table "form_values", force: :cascade do |t|
    t.integer  "form_value_index"
    t.integer  "daily_form_id"
    t.integer  "customer_id"
    t.integer  "delivery_person_id"
    t.integer  "key1"
    t.integer  "key2"
    t.integer  "key3"
    t.integer  "key4"
    t.integer  "key5"
    t.integer  "key6"
    t.integer  "key7"
    t.integer  "key8"
    t.string   "note"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "form_values", ["customer_id"], name: "index_form_values_on_customer_id"
  add_index "form_values", ["daily_form_id"], name: "index_form_values_on_daily_form_id"
  add_index "form_values", ["delivery_person_id"], name: "index_form_values_on_delivery_person_id"

  create_table "manufacturer_keys", force: :cascade do |t|
    t.integer  "manufacturer_id"
    t.string   "name"
    t.string   "note"
    t.integer  "mapping_key"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "manufacturer_keys", ["manufacturer_id"], name: "index_manufacturer_keys_on_manufacturer_id"

  create_table "manufacturers", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "phones", force: :cascade do |t|
    t.string   "number"
    t.integer  "phone_link_id"
    t.string   "phone_link_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "username"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
