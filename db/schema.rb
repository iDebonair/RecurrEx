# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_20_223406) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reminders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "subscription_id"
    t.boolean "email"
    t.integer "timing"
    t.text "frequency"
    t.bigint "users_id", null: false
    t.bigint "subscriptions_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscriptions_id"], name: "index_reminders_on_subscriptions_id"
    t.index ["users_id"], name: "index_reminders_on_users_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "name"
    t.float "cost"
    t.date "renewal_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "frequency"
    t.bigint "category_id"
    t.date "start_date"
    t.index ["category_id"], name: "index_subscriptions_on_category_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "user_subscription_bridge", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "subscription_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "subscription_id"], name: "index_user_subscription_bridge_on_user_id_and_subscription_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password"
    t.string "password_confirmation"
  end

  add_foreign_key "reminders", "subscriptions", column: "subscriptions_id"
  add_foreign_key "reminders", "users", column: "users_id"
  add_foreign_key "subscriptions", "categories"
  add_foreign_key "subscriptions", "users"
end
