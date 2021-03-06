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

ActiveRecord::Schema.define(version: 20150930174033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "episodes", force: :cascade do |t|
    t.string   "title"
    t.string   "link"
    t.string   "published_date"
    t.string   "duration"
    t.string   "audio_url"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "podcast_id"
  end

  add_index "episodes", ["podcast_id"], name: "index_episodes_on_podcast_id", using: :btree
  add_index "episodes", ["user_id"], name: "index_episodes_on_user_id", using: :btree

  create_table "podcast_suggestions", force: :cascade do |t|
    t.string   "suggestion"
    t.string   "status",     default: "pending"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "podcasts", force: :cascade do |t|
    t.string   "name"
    t.string   "feed_url"
    t.string   "image"
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "screen_name"
    t.string   "uid"
    t.string   "profile_image_url"
    t.string   "oauth_token"
    t.string   "oauth_token_secret"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "role",               default: 0
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "episode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "votes", ["episode_id"], name: "index_votes_on_episode_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  add_foreign_key "episodes", "podcasts"
  add_foreign_key "episodes", "users"
  add_foreign_key "votes", "episodes"
  add_foreign_key "votes", "users"
end
