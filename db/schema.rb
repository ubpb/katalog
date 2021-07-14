# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_02_092543) do

  create_table "cache_entries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key"
    t.text "value", size: :long
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["key"], name: "index_cache_entries_on_key"
  end

  create_table "notes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "record_id"
    t.text "value", size: :long
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "scope_id"
    t.index ["record_id"], name: "index_notes_on_record_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "permalinks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "scope", null: false
    t.text "search_request", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_resolved_at"
    t.index ["key"], name: "index_permalinks_on_key"
  end

  create_table "searches", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.text "request", size: :long
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "server_response_id"
    t.text "hashed_id", size: :long
    t.text "query", size: :long
    t.index ["hashed_id"], name: "index_searches_on_hashed_id", length: 200
    t.index ["server_response_id"], name: "index_searches_on_server_response_id"
  end

  create_table "server_responses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "request_hash", size: :long
    t.text "data", size: :long
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_hash"], name: "index_server_responses_on_request_hash", length: 200
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email_address"
    t.date "expiry_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ilsusername"
    t.string "pseudonym"
    t.string "api_key"
    t.string "password_reset_token"
    t.datetime "password_reset_token_created_at"
    t.string "ilsuserid"
    t.index ["api_key"], name: "index_users_on_api_key", unique: true
    t.index ["ilsuserid"], name: "index_users_on_ilsuserid", unique: true
    t.index ["ilsusername"], name: "index_users_on_ilsusername", unique: true
    t.index ["pseudonym"], name: "index_users_on_pseudonym", unique: true
  end

  create_table "watch_list_entries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "watch_list_id"
    t.string "record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "scope_id", null: false
    t.boolean "pci_cdi_migration"
    t.string "pci_record_id"
    t.index ["record_id"], name: "index_watch_list_entries_on_record_id"
    t.index ["scope_id"], name: "index_watch_list_entries_on_scope_id"
    t.index ["watch_list_id"], name: "index_watch_list_entries_on_watch_list_id"
  end

  create_table "watch_lists", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.text "description", size: :long
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_watch_lists_on_user_id"
  end

  add_foreign_key "notes", "users", on_delete: :cascade
  add_foreign_key "watch_list_entries", "watch_lists", on_delete: :cascade
  add_foreign_key "watch_lists", "users", on_delete: :cascade
end
