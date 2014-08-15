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

ActiveRecord::Schema.define(version: 20140815063227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "kitchens", force: true do |t|
    t.string   "name",           null: false
    t.string   "description",    null: false
    t.string   "street_address", null: false
    t.string   "city",           null: false
    t.string   "state",          null: false
    t.string   "zipcode",        null: false
    t.float    "latitude"
    t.float    "longtitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "kitchens", ["user_id"], name: "index_kitchens_on_user_id", using: :btree

  create_table "reservations", force: true do |t|
    t.string   "status",       default: "pending", null: false
    t.date     "reserve_date",                     null: false
    t.time     "reserve_time",                     null: false
    t.string   "message"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_id"
    t.integer  "kitchen_id"
  end

  add_index "reservations", ["kitchen_id"], name: "index_reservations_on_kitchen_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "nickname",        null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
