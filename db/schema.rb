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

ActiveRecord::Schema[7.0].define(version: 2026_05_19_102950) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "care_items", force: :cascade do |t|
    t.bigint "pet_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_care_items_on_pet_id"
  end

  create_table "care_records", force: :cascade do |t|
    t.bigint "pet_id", null: false
    t.bigint "care_item_id", null: false
    t.datetime "recorded_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["care_item_id"], name: "index_care_records_on_care_item_id"
    t.index ["pet_id", "care_item_id", "recorded_at"], name: "index_care_records_on_pet_item_and_time", unique: true
    t.index ["pet_id"], name: "index_care_records_on_pet_id"
    t.index ["user_id"], name: "index_care_records_on_user_id"
  end

  create_table "group_members", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_members_on_group_id"
    t.index ["user_id", "group_id"], name: "index_group_members_on_user_id_and_group_id", unique: true
    t.index ["user_id"], name: "index_group_members_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.string "invite_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invite_code"], name: "index_groups_on_invite_code"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name", null: false
    t.string "species"
    t.integer "gender", default: 0, null: false
    t.integer "age"
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_pets_on_group_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "care_items", "pets"
  add_foreign_key "care_records", "care_items"
  add_foreign_key "care_records", "pets"
  add_foreign_key "care_records", "users"
  add_foreign_key "group_members", "groups"
  add_foreign_key "group_members", "users"
  add_foreign_key "pets", "groups"
end
