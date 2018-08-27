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

ActiveRecord::Schema.define(version: 4) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "frame_by_users", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "user_id"
    t.integer "final_score", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_frame_by_users_on_game_id"
    t.index ["user_id"], name: "index_frame_by_users_on_user_id"
  end

  create_table "frames", force: :cascade do |t|
    t.bigint "frame_by_user_id"
    t.integer "try1"
    t.integer "try2"
    t.integer "try3"
    t.integer "score"
    t.integer "turn"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["frame_by_user_id"], name: "index_frames_on_frame_by_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "players"
    t.string "winner"
    t.integer "turn", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "frame_by_users", "games"
  add_foreign_key "frame_by_users", "users"
  add_foreign_key "frames", "frame_by_users"
end
