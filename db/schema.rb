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

ActiveRecord::Schema.define(version: 20140408231714) do

  create_table "bracket_placements", force: true do |t|
    t.string  "placement"
    t.date    "game_date"
    t.integer "team_id"
    t.string  "game_type"
    t.string  "game_number"
    t.string  "selection_type"
    t.string  "selection_code"
  end

  create_table "brackets", force: true do |t|
    t.integer  "user_id"
    t.integer  "a1"
    t.integer  "b2"
    t.integer  "c1"
    t.integer  "d2"
    t.integer  "b1"
    t.integer  "a2"
    t.integer  "d1"
    t.integer  "c2"
    t.integer  "e1"
    t.integer  "f2"
    t.integer  "g1"
    t.integer  "h2"
    t.integer  "f1"
    t.integer  "e2"
    t.integer  "h1"
    t.integer  "g2"
    t.integer  "w49"
    t.integer  "w50"
    t.integer  "w51"
    t.integer  "w52"
    t.integer  "w53"
    t.integer  "w54"
    t.integer  "w55"
    t.integer  "w56"
    t.integer  "w57"
    t.integer  "w58"
    t.integer  "w59"
    t.integer  "w60"
    t.integer  "l61"
    t.integer  "l62"
    t.integer  "w61"
    t.integer  "w62"
    t.integer  "third"
    t.integer  "champion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "group_name"
    t.integer  "leader"
    t.integer  "organizer"
    t.string   "passcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.string  "user_screen_name"
  end

  create_table "teams", force: true do |t|
    t.string "name"
    t.string "group"
    t.string "nombre"
    t.string "flag_url"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
