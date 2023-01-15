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

ActiveRecord::Schema[7.0].define(version: 2022_12_31_043937) do
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

  create_table "channel_memberships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "channel_id", null: false
    t.integer "mention_count", default: 0, null: false
    t.integer "new_message_count", default: 0, null: false
    t.datetime "last_visited"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_channel_memberships_on_channel_id"
    t.index ["user_id", "channel_id"], name: "index_channel_memberships_on_user_id_and_channel_id", unique: true
    t.index ["user_id"], name: "index_channel_memberships_on_user_id"
  end

  create_table "channels", force: :cascade do |t|
    t.string "context_type", null: false
    t.integer "context_id", null: false
    t.string "title", null: false
    t.integer "order", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["context_type", "context_id", "title"], name: "index_channels_on_context_type_and_context_id_and_title", unique: true
    t.index ["context_type", "context_id"], name: "index_channels_on_context"
  end

  create_table "club_memberships", force: :cascade do |t|
    t.integer "club_id", null: false
    t.integer "user_id", null: false
    t.integer "order", null: false
    t.string "role", null: false
    t.boolean "banned", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_club_memberships_on_club_id"
    t.index ["user_id", "club_id"], name: "index_club_memberships_on_user_id_and_club_id", unique: true
    t.index ["user_id"], name: "index_club_memberships_on_user_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.integer "institution_id", null: false
    t.string "title", null: false
    t.string "icon"
    t.integer "creator_id"
    t.boolean "public", default: true, null: false
    t.string "encrypted_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["creator_id"], name: "index_clubs_on_creator_id"
    t.index ["institution_id", "title"], name: "index_clubs_on_institution_id_and_title", unique: true
    t.index ["institution_id"], name: "index_clubs_on_institution_id"
  end

  create_table "course_memberships", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "user_id", null: false
    t.integer "order", null: false
    t.string "role", null: false
    t.boolean "banned", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_memberships_on_course_id"
    t.index ["user_id", "course_id"], name: "index_course_memberships_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_course_memberships_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer "institution_id", null: false
    t.string "title", null: false
    t.string "icon"
    t.string "code"
    t.string "department"
    t.integer "creator_id"
    t.boolean "public", default: true, null: false
    t.string "encrypted_password"
    t.integer "year"
    t.string "term"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["creator_id"], name: "index_courses_on_creator_id"
    t.index ["institution_id", "code", "year", "term"], name: "index_courses_on_institution_id_and_code_and_year_and_term", unique: true
    t.index ["institution_id", "title", "year", "term"], name: "index_courses_on_institution_id_and_title_and_year_and_term", unique: true
    t.index ["institution_id"], name: "index_courses_on_institution_id"
  end

  create_table "domains", force: :cascade do |t|
    t.integer "institution_id", null: false
    t.string "domain", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_domains_on_institution_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.string "institution_type"
    t.string "url_slug"
    t.string "home_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "institution_type"], name: "index_institutions_on_name_and_institution_type", unique: true
    t.index ["url_slug"], name: "index_institutions_on_url_slug", unique: true
  end

  create_table "interest_memberships", force: :cascade do |t|
    t.integer "interest_id", null: false
    t.integer "user_id", null: false
    t.integer "order", null: false
    t.string "role", null: false
    t.boolean "banned", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interest_id"], name: "index_interest_memberships_on_interest_id"
    t.index ["user_id", "interest_id"], name: "index_interest_memberships_on_user_id_and_interest_id", unique: true
    t.index ["user_id"], name: "index_interest_memberships_on_user_id"
  end

  create_table "interests", force: :cascade do |t|
    t.integer "institution_id", null: false
    t.string "title", null: false
    t.string "icon"
    t.integer "creator_id"
    t.boolean "public", default: true, null: false
    t.string "encrypted_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["creator_id"], name: "index_interests_on_creator_id"
    t.index ["institution_id", "title"], name: "index_interests_on_institution_id_and_title", unique: true
    t.index ["institution_id"], name: "index_interests_on_institution_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "pdf_tabs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "channel_id", null: false
    t.text "post_text", null: false
    t.integer "reply_to_id_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["channel_id"], name: "index_posts_on_channel_id"
    t.index ["discarded_at"], name: "index_posts_on_discarded_at"
    t.index ["reply_to_id_id"], name: "index_posts_on_reply_to_id_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "reactions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.string "reaction", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_reactions_on_post_id"
    t.index ["user_id", "post_id", "reaction"], name: "index_reactions_on_user_id_and_post_id_and_reaction", unique: true
    t.index ["user_id"], name: "index_reactions_on_user_id"
  end

  create_table "rich_text_tabs", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "syllabuses", force: :cascade do |t|
    t.text "rich_text"
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_syllabuses_on_course_id", unique: true
  end

  create_table "tabs", force: :cascade do |t|
    t.string "context_type", null: false
    t.integer "context_id", null: false
    t.string "name", null: false
    t.integer "order", null: false
    t.string "tab_entity_type", null: false
    t.integer "tab_entity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["context_type", "context_id"], name: "index_tabs_on_context"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "user_type", null: false
    t.text "description"
    t.string "profile_picture_url"
    t.integer "institution_id", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["institution_id"], name: "index_users_on_institution_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "channel_memberships", "channels"
  add_foreign_key "channel_memberships", "users"
  add_foreign_key "club_memberships", "clubs"
  add_foreign_key "club_memberships", "users"
  add_foreign_key "clubs", "institutions"
  add_foreign_key "clubs", "users", column: "creator_id"
  add_foreign_key "course_memberships", "courses"
  add_foreign_key "course_memberships", "users"
  add_foreign_key "courses", "institutions"
  add_foreign_key "courses", "users", column: "creator_id"
  add_foreign_key "domains", "institutions"
  add_foreign_key "interest_memberships", "interests"
  add_foreign_key "interest_memberships", "users"
  add_foreign_key "interests", "institutions"
  add_foreign_key "interests", "users", column: "creator_id"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "posts", "channels"
  add_foreign_key "posts", "posts", column: "reply_to_id_id"
  add_foreign_key "posts", "users"
  add_foreign_key "reactions", "posts"
  add_foreign_key "reactions", "users"
  add_foreign_key "syllabuses", "courses"
  add_foreign_key "users", "institutions"
end
