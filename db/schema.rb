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

ActiveRecord::Schema.define(version: 20150309160456) do

  create_table "bracket_entries", force: true do |t|
    t.integer  "ncaa_team_id"
    t.integer  "seed"
    t.integer  "region_id"
    t.integer  "year"
    t.integer  "round"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "draft_picks", force: true do |t|
    t.integer  "overall_pick"
    t.integer  "round"
    t.integer  "ncaa_player_id"
    t.integer  "mm_team_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "draft_id"
  end

  add_index "draft_picks", ["ncaa_player_id"], name: "index_draft_picks_on_ncaa_player_id", unique: true, using: :btree

  create_table "drafts", force: true do |t|
    t.integer  "total_rounds"
    t.integer  "total_teams"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "mm_team_preferred_players", force: true do |t|
    t.integer  "mm_team_id"
    t.integer  "ncaa_player_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "mm_team_preferred_players", ["ncaa_player_id", "mm_team_id"], name: "index_mm_team_preferred_players_on_ncaa_player_id_and_mm_team_id", unique: true, using: :btree

  create_table "mm_teams", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ncaa_players", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "ncaa_team_id"
    t.decimal  "ppg_avg",       precision: 10, scale: 1
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "jersey_number"
    t.string   "web_id"
  end

  add_index "ncaa_players", ["first_name", "last_name", "ncaa_team_id"], name: "index_ncaa_players_on_first_name_and_last_name_and_ncaa_team_id", unique: true, using: :btree

  create_table "ncaa_teams", force: true do |t|
    t.string   "school"
    t.string   "nickname"
    t.integer  "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "web_id"
  end

  create_table "player_scorings", force: true do |t|
    t.integer  "ncaa_player_id"
    t.integer  "round"
    t.integer  "points"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "player_scorings", ["ncaa_player_id", "round"], name: "index_player_scorings_on_ncaa_player_id_and_round", unique: true, using: :btree

  create_table "regions", force: true do |t|
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "is_admin",                           default: 0,  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
