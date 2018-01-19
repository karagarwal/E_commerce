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

ActiveRecord::Schema.define(version: 20180119043328) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "invoice_number", limit: 4
    t.integer  "amount",         limit: 4
    t.integer  "order_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["order_id"], name: "fk_rails_4fa42a6dca", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.decimal  "price",                   precision: 10
    t.decimal  "weight",                  precision: 10
    t.string   "brand",       limit: 255
    t.integer  "category_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["category_id"], name: "fk_rails_89fb86dc8b", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "order_number", limit: 4
    t.string   "payment_mode", limit: 255
    t.integer  "item_id",      limit: 4
    t.integer  "user_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["item_id"], name: "fk_rails_fc971cd604", using: :btree
  add_index "orders", ["user_id"], name: "fk_rails_f868b47f6a", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.string   "phone",      limit: 255
    t.integer  "gender",     limit: 4
    t.string   "username",   limit: 255
    t.string   "password",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "invoices", "orders"
  add_foreign_key "items", "categories"
  add_foreign_key "orders", "items"
  add_foreign_key "orders", "users"
end
