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

ActiveRecord::Schema.define(version: 20151011100712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_name",                       null: false
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "email"
    t.boolean  "email_confirmed", default: false
    t.string   "password_digest",                 null: false
    t.string   "auth_token"
    t.string   "description"
    t.string   "sign_up_token"
    t.datetime "sign_up_sent_at"
    t.string   "longitude"
    t.string   "latitude"
    t.datetime "last_active"
    t.integer  "likes",           default: 25
    t.string   "looking_for"
    t.string   "orientation"
    t.string   "gender"
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body",                       null: false
    t.datetime "sent_at"
    t.boolean  "read",       default: false
    t.datetime "read_at"
  end

end
