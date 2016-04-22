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

ActiveRecord::Schema.define(version: 20160422010504) do

  create_table "account_records", force: :cascade do |t|
    t.date     "pay_occurrence_date",                                       null: false
    t.datetime "pay_occurrence_time",                                       null: false
    t.integer  "pay_user_id",          limit: 4,                            null: false
    t.string   "pay_symbol",           limit: 2,                            null: false
    t.decimal  "pay_amount",                       precision: 10, scale: 2, null: false
    t.string   "pay_currency",         limit: 3,                            null: false
    t.string   "pay_method",           limit: 20,                           null: false
    t.string   "pay_reason",           limit: 255
    t.datetime "pay_actual_time"
    t.string   "pay_partner",          limit: 255
    t.string   "consumption_type",     limit: 5,                            null: false
    t.string   "consumption_sub_type", limit: 10
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  add_index "account_records", ["pay_user_id", "pay_occurrence_date"], name: "index_account_records_1", using: :btree

  create_table "account_users", force: :cascade do |t|
    t.string   "username",   limit: 20,                                         null: false
    t.string   "password",   limit: 255,                                        null: false
    t.decimal  "income",                 precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "outcome",                precision: 10, scale: 2, default: 0.0, null: false
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
  end

  add_index "account_users", ["username"], name: "index_account_users_1", using: :btree

end
