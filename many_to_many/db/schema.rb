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

ActiveRecord::Schema[7.2].define(version: 2024_10_11_182827) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.text "email", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "blocked", default: false, null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
  end

  create_table "accounts_projects", id: false, force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "project_id", null: false
  end

  create_table "labels", force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_labels_on_name", unique: true
  end

  create_table "labels_projects", id: false, force: :cascade do |t|
    t.bigint "label_id", null: false
    t.bigint "project_id", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.text "name"
    t.text "body"
    t.json "participants"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
