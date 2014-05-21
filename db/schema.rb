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

ActiveRecord::Schema.define(version: 20140521024817) do

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
    t.string   "slug"
    t.integer  "a1s"
    t.integer  "b2s"
    t.integer  "c1s"
    t.integer  "d2s"
    t.integer  "b1s"
    t.integer  "a2s"
    t.integer  "d1s"
    t.integer  "c2s"
    t.integer  "e1s"
    t.integer  "f2s"
    t.integer  "g1s"
    t.integer  "h2s"
    t.integer  "f1s"
    t.integer  "e2s"
    t.integer  "h1s"
    t.integer  "g2s"
    t.integer  "w49s"
    t.integer  "w50s"
    t.integer  "w51s"
    t.integer  "w52s"
    t.integer  "w53s"
    t.integer  "w54s"
    t.integer  "w55s"
    t.integer  "w56s"
    t.integer  "w57s"
    t.integer  "w58s"
    t.integer  "w59s"
    t.integer  "w60s"
    t.integer  "l61s"
    t.integer  "l62s"
    t.integer  "w61s"
    t.integer  "w62s"
    t.integer  "thirds"
    t.integer  "champions"
    t.integer  "score"
    t.integer  "full_r16"
    t.integer  "half_r16"
    t.integer  "full_quaterfinals"
    t.integer  "half_quaterfinals"
    t.integer  "full_semifinals"
    t.integer  "half_semifinals"
    t.integer  "full_total"
    t.integer  "half_total"
  end

  create_table "final_positions", force: true do |t|
    t.string   "position"
    t.integer  "team"
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
    t.string   "slug"
    t.boolean  "isprivate"
    t.boolean  "others_can_invite"
  end

  create_table "memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "user_screen_name"
    t.time     "last_viewed"
    t.integer  "full_r16"
    t.integer  "half_r16"
    t.integer  "full_quaterfinals"
    t.integer  "half_quaterfinals"
    t.integer  "full_semifinals"
    t.integer  "half_semifinals"
    t.integer  "full_total"
    t.integer  "half_total"
    t.integer  "score"
    t.integer  "full_final"
    t.integer  "full_third"
    t.integer  "third"
    t.integer  "champion"
    t.datetime "bracket_updated_at"
  end

  create_table "register_attempts", force: true do |t|
    t.string   "email"
    t.string   "passcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string  "name"
    t.string  "group"
    t.string  "nombre"
    t.string  "flag_url"
    t.integer "r16_selections"
    t.integer "quaterfinals_selections"
    t.integer "semifinals_selections"
    t.integer "final_selections"
    t.integer "third_match_selections"
    t.integer "champion_selections"
    t.integer "third_selections"
    t.string  "r16_position"
    t.boolean "r16_madeit"
    t.string  "quaterfinals_position"
    t.boolean "quaterfinals_madeit"
    t.string  "semifinals_position"
    t.boolean "semifinals_madeit"
    t.boolean "final_madeit"
    t.boolean "third_match_madeit"
    t.boolean "third_place_madeit"
    t.boolean "champion_madeit"
    t.boolean "r16_defined"
    t.boolean "quaterfinals_defined"
    t.boolean "semifinals_defined"
    t.boolean "final_defined"
    t.boolean "third_match_defined"
    t.boolean "third_place_defined"
    t.boolean "champion_defined"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "admin"
    t.boolean  "admin_view"
    t.string   "screenname"
  end

end
