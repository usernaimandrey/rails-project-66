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

ActiveRecord::Schema.define(version: 2022_10_28_224101) do

  create_table "repositories", force: :cascade do |t|
    t.string "full_name"
    t.string "name"
    t.string "language"
    t.datetime "repo_created_at"
    t.datetime "repo_updated_at"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "clone_url"
    t.integer "github_id"
    t.string "default_branch"
    t.index ["github_id"], name: "index_repositories_on_github_id", unique: true
    t.index ["user_id"], name: "index_repositories_on_user_id"
  end

  create_table "repository_check_linter_errors", force: :cascade do |t|
    t.string "message"
    t.string "rule"
    t.string "line_column"
    t.string "file_path"
    t.integer "check_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["check_id"], name: "index_repository_check_linter_errors_on_check_id"
  end

  create_table "repository_checks", force: :cascade do |t|
    t.boolean "passed", default: false
    t.string "aasm_state"
    t.integer "repository_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "errors_count"
    t.string "last_commit_sha"
    t.string "last_commit_url"
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
  add_foreign_key "repository_check_linter_errors", "repository_checks", column: "check_id", on_delete: :cascade
  add_foreign_key "repository_checks", "repositories", on_delete: :cascade
end
