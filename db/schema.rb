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

ActiveRecord::Schema.define(version: 20150312021128) do

  create_table "bracket_entries", force: :cascade do |t|
    t.integer  "ncaa_team_id", limit: 4
    t.integer  "seed",         limit: 4
    t.integer  "region_id",    limit: 4
    t.integer  "year",         limit: 4
    t.integer  "round",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_play_in",             default: false
  end

  create_table "draft_picks", force: :cascade do |t|
    t.integer  "overall_pick",   limit: 4
    t.integer  "round",          limit: 4
    t.integer  "ncaa_player_id", limit: 4
    t.integer  "mm_team_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "draft_id",       limit: 4
  end

  add_index "draft_picks", ["ncaa_player_id"], name: "index_draft_picks_on_ncaa_player_id", unique: true, using: :btree

  create_table "drafts", force: :cascade do |t|
    t.integer  "total_rounds", limit: 4
    t.integer  "total_teams",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mm_team_preferred_players", force: :cascade do |t|
    t.integer  "mm_team_id",     limit: 4
    t.integer  "ncaa_player_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mm_team_preferred_players", ["ncaa_player_id", "mm_team_id"], name: "index_mm_team_preferred_players_on_ncaa_player_id_and_mm_team_id", unique: true, using: :btree

  create_table "mm_teams", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "year",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ncaa_players", force: :cascade do |t|
    t.string   "first_name",    limit: 255
    t.string   "last_name",     limit: 255
    t.integer  "ncaa_team_id",  limit: 4
    t.decimal  "ppg_avg",                   precision: 10, scale: 1
    t.string   "position",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "jersey_number", limit: 4
    t.string   "web_id",        limit: 255
  end

  add_index "ncaa_players", ["first_name", "last_name", "ncaa_team_id"], name: "index_ncaa_players_on_first_name_and_last_name_and_ncaa_team_id", unique: true, using: :btree

  create_table "ncaa_teams", force: :cascade do |t|
    t.string   "school",     limit: 255
    t.string   "nickname",   limit: 255
    t.integer  "is_active",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "web_id",     limit: 255
  end

  create_table "player_scorings", force: :cascade do |t|
    t.integer  "ncaa_player_id", limit: 4
    t.integer  "round",          limit: 4
    t.integer  "points",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_scorings", ["ncaa_player_id", "round"], name: "index_player_scorings_on_ncaa_player_id_and_round", unique: true, using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "location",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.integer  "is_admin",               limit: 4,   default: 0,  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
