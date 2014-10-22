# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141022233048) do

  create_table "accounts", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "form_fields", force: true do |t|
    t.integer  "form_id"
    t.string   "title"
    t.string   "data_type"
    t.text     "options"
    t.boolean  "required",   default: false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms", force: true do |t|
    t.integer  "site_id"
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.text     "body"
    t.text     "thank_you_body"
    t.text     "notification_emails"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_galleries", force: true do |t|
    t.integer  "site_id"
    t.string   "title"
    t.string   "slug"
    t.boolean  "public",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.integer  "gallery_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_type_field_groups", force: true do |t|
    t.integer  "page_type_id"
    t.string   "title"
    t.string   "slug"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_type_fields", force: true do |t|
    t.integer  "page_type_field_group_id"
    t.string   "title"
    t.string   "slug"
    t.string   "data_type"
    t.text     "options"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_types", force: true do |t|
    t.integer  "site_id"
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.string   "icon"
    t.string   "template"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.integer  "page_type_id"
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.text     "body"
    t.string   "ancestry"
    t.boolean  "published",    default: false
    t.text     "field_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", force: true do |t|
    t.integer  "account_id"
    t.string   "title"
    t.string   "slug"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.boolean  "is_admin",               default: false
    t.string   "name"
    t.text     "settings"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
