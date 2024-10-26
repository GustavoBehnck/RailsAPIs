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

ActiveRecord::Schema[7.2].define(version: 2024_10_07_190718) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.text "name", null: false
    t.text "email", null: false
    t.text "phone", null: false
    t.boolean "archived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest", null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.text "name", null: false
    t.date "date_proj_started"
    t.text "txt_body", null: false
    t.boolean "blocked", default: false
    t.bigint "account_id", null: false
    t.json "participants", null: false
    t.text "status", default: "Em progresso", null: false
    t.text "file_path", null: false
    t.text "keywords", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_projects_on_account_id"
  end

  add_foreign_key "projects", "accounts"
end
