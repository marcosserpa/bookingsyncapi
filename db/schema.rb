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

ActiveRecord::Schema.define(version: 20171029182005) do

  create_table "bookings", force: :cascade do |t|
    t.integer  "rental_id",    null: false
    t.datetime "start_at",     null: false
    t.datetime "end_at",       null: false
    t.string   "client_email", null: false
    t.float    "price",        null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "bookings", ["rental_id"], name: "index_bookings_on_rental_id"

  create_table "rentals", force: :cascade do |t|
    t.string   "name",       null: false
    t.float    "daily_rate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
