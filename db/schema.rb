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

ActiveRecord::Schema.define(version: 2022_10_09_135242) do

  create_table "repositories", force: :cascade do |t|
    t.string "link"
    t.string "repo_name"
    t.string "language"
    t.datetime "repo_created_at"
    t.datetime "repo_updated_at"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "clone_url"
    t.index ["link"], name: "index_repositories_on_link", unique: true
    t.index ["user_id"], name: "index_repositories_on_user_id"
  end

  create_table "repository_check_file_path_linter_errors", force: :cascade do |t|
    t.string "message"
    t.string "rule"
    t.string "line_column"
    t.integer "file_path_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["file_path_id"], name: "index_repository_check_file_path_linter_errors_on_file_path_id"
  end

  create_table "repository_check_file_paths", force: :cascade do |t|
    t.string "path"
    t.integer "check_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["check_id"], name: "index_repository_check_file_paths_on_check_id"
  end

  create_table "repository_checks", force: :cascade do |t|
    t.boolean "check_passed"
    t.string "state"
    t.integer "repository_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["repository_id"], name: "index_repository_checks_on_repository_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname"
    t.string "name"
    t.string "email"
    t.string "token"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "repositories", "users", on_delete: :cascade
  add_foreign_key "repository_check_file_path_linter_errors", "repository_check_file_paths", column: "file_path_id", on_delete: :cascade
  add_foreign_key "repository_check_file_paths", "repository_checks", column: "check_id", on_delete: :cascade
  add_foreign_key "repository_checks", "repositories", on_delete: :cascade
end
