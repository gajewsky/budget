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

ActiveRecord::Schema[7.0].define(version: 2022_10_08_145159) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.datetime "operation_date", precision: nil
    t.bigint "user_id"
    t.bigint "contractor_id"
    t.boolean "to_divide", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["contractor_id"], name: "index_bills_on_contractor_id"
    t.index ["user_id"], name: "index_bills_on_user_id"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.text "description"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "kind", default: 0
  end

  create_table "contractors", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "card_info"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "subcategory_id"
    t.string "revolut_id"
    t.index ["subcategory_id"], name: "index_contractors_on_subcategory_id"
  end

  create_table "expenses", id: :serial, force: :cascade do |t|
    t.datetime "operation_date", precision: nil
    t.text "description"
    t.decimal "value"
    t.integer "subcategory_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "to_divide", default: false
    t.boolean "track", default: false
    t.bigint "contractor_id"
    t.bigint "bill_id"
    t.index ["bill_id"], name: "index_expenses_on_bill_id"
    t.index ["contractor_id"], name: "index_expenses_on_contractor_id"
    t.index ["subcategory_id"], name: "index_expenses_on_subcategory_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "incomes", id: :serial, force: :cascade do |t|
    t.decimal "value"
    t.datetime "operation_date", precision: nil
    t.integer "subcategory_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.text "description"
    t.integer "user_id"
    t.index ["subcategory_id"], name: "index_incomes_on_subcategory_id"
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "subcategories", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.text "description"
    t.integer "category_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type", limit: 255
    t.integer "tagger_id"
    t.string "tagger_type", limit: 255
    t.string "context", limit: 128
    t.datetime "created_at", precision: nil
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "avatar", limit: 255
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
