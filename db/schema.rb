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

ActiveRecord::Schema.define(version: 2022_12_12_133324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "categories_movies", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_categories_movies_on_category_id"
    t.index ["movie_id"], name: "index_categories_movies_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.string "description", default: "", null: false
    t.string "title_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "movie_id"
    t.integer "grade", default: 0, null: false
    t.index ["movie_id"], name: "index_ratings_on_movie_id"
    t.index ["user_id", "movie_id"], name: "index_ratings_on_user_id_and_movie_id", unique: true
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "password", default: "", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "categories_movies", "categories"
  add_foreign_key "categories_movies", "movies"
  add_foreign_key "ratings", "movies"
  add_foreign_key "ratings", "users"
end
