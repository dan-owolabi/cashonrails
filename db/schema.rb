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

ActiveRecord::Schema[7.2].define(version: 2024_01_01_000003) do
  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "compliance_access", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "identity_verifications", force: :cascade do |t|
    t.integer "merchant_id", null: false
    t.integer "admin_user_id", null: false
    t.string "id_type", null: false
    t.string "id_number", null: false
    t.string "full_name"
    t.date "date_of_birth"
    t.string "phone_number"
    t.string "gender"
    t.string "image_url"
    t.string "status", default: "pending"
    t.json "raw_response"
    t.string "provider", default: "samson"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_identity_verifications_on_admin_user_id"
    t.index ["id_type", "id_number"], name: "index_identity_verifications_on_id_type_and_id_number"
    t.index ["merchant_id"], name: "index_identity_verifications_on_merchant_id"
    t.index ["status"], name: "index_identity_verifications_on_status"
  end

  create_table "merchants", force: :cascade do |t|
    t.string "business_name", null: false
    t.string "status", default: "pending", null: false
    t.integer "business_id_number"
    t.string "reviewed_by"
    t.integer "confidence_score"
    t.integer "attempts", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "identity_verifications", "admin_users"
  add_foreign_key "identity_verifications", "merchants"
end
