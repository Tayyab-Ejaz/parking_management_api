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

ActiveRecord::Schema[7.1].define(version: 2024_05_04_211041) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "car_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "car_types_parking_slots", id: false, force: :cascade do |t|
    t.bigint "parking_slot_id", null: false
    t.bigint "car_type_id", null: false
  end

  create_table "parking_slots", force: :cascade do |t|
    t.text "description"
    t.boolean "for_disabled_only", default: false
    t.boolean "has_shade", default: true
    t.boolean "is_available", default: true
    t.decimal "price_per_hour", default: "0.0"
    t.datetime "availability_time_start", default: "1970-01-01 00:00:00"
    t.datetime "availability_time_end", default: "1970-01-01 23:59:00"
    t.integer "cancel_fee_in_percentage", default: 50
    t.string "cancellation_window_in_minutes", default: "60"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "parking_slot_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "status", default: 0
    t.datetime "checkin_time"
    t.datetime "checkout_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parking_slot_id"], name: "index_reservations_on_parking_slot_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.string "name", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "working_hours", force: :cascade do |t|
    t.bigint "parking_slot_id", null: false
    t.integer "day", null: false
    t.boolean "closed"
    t.time "start_time", default: "2000-01-01 18:00:00"
    t.time "end_time", default: "2000-01-01 18:00:00"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parking_slot_id", "day"], name: "index_working_hours_on_parking_slot_id_and_day", unique: true
    t.index ["parking_slot_id"], name: "index_working_hours_on_parking_slot_id"
  end

  add_foreign_key "reservations", "parking_slots"
  add_foreign_key "reservations", "users"
  add_foreign_key "working_hours", "parking_slots"
end
