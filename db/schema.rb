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

ActiveRecord::Schema[7.1].define(version: 2024_01_24_113015) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "amenities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "flat_id", null: false
    t.integer "total_price"
    t.string "start_time"
    t.string "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flat_id"], name: "index_bookings_on_flat_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "flat_amenities", force: :cascade do |t|
    t.bigint "flat_id", null: false
    t.bigint "amenity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amenity_id"], name: "index_flat_amenities_on_amenity_id"
    t.index ["flat_id"], name: "index_flat_amenities_on_flat_id"
  end

  create_table "flats", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "bedrooms", default: 1
    t.integer "price"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "zip", null: false
    t.string "city", null: false
    t.string "country", null: false
    t.string "street", null: false
    t.string "address", null: false
    t.integer "guests", default: 2, null: false
    t.integer "baths", default: 1, null: false
    t.time "checkin", default: "2000-01-01 08:00:00"
    t.time "checkout", default: "2000-01-01 22:00:00"
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_flats_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "flat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flat_id"], name: "index_likes_on_flat_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "flat_id", null: false
    t.text "comment"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flat_id"], name: "index_reviews_on_flat_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "flats"
  add_foreign_key "bookings", "users"
  add_foreign_key "flat_amenities", "amenities"
  add_foreign_key "flat_amenities", "flats"
  add_foreign_key "flats", "users"
  add_foreign_key "likes", "flats"
  add_foreign_key "likes", "users"
  add_foreign_key "reviews", "flats"
  add_foreign_key "reviews", "users"
end
