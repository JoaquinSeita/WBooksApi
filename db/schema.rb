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

ActiveRecord::Schema.define(version: 2021_10_27_184849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "genre", null: false
    t.string "author", null: false
    t.string "image", null: false
    t.string "title", null: false
    t.string "publisher", null: false
    t.string "year", null: false
    t.boolean "available", default: true
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "rents", force: :cascade do |t|
    t.date "from", null: false
    t.date "to", null: false
    t.date "returned_at"
    t.bigint "user_id"
    t.bigint "book_id"
    t.index ["book_id"], name: "index_rents_on_book_id"
    t.index ["user_id"], name: "index_rents_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "unread_notifications_count", default: 0, null: false
    t.integer "rents_count", default: 0, null: false
    t.integer "comments_count", default: 0, null: false
    t.integer "wishes_count", default: 0, null: false
    t.string "locale", default: "en", null: false
    t.string "image_url", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "rents", "books"
  add_foreign_key "rents", "users"
end
