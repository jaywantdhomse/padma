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

ActiveRecord::Schema.define(version: 20161219144748) do

  create_table "applicants", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "apply_for"
    t.string   "email"
    t.string   "phone"
    t.string   "current_organization"
    t.string   "current_profile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.binary   "avatar",      limit: 2147483647
  end

  create_table "contact_us", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "city"
    t.string   "address"
    t.string   "pincode"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "distributor_complaints", force: true do |t|
    t.string   "by"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "city"
    t.string   "address"
    t.string   "pincode"
    t.string   "product"
    t.string   "model"
    t.string   "complaint"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guardian_name"
    t.date     "dob"
    t.string   "gender"
    t.string   "educational_qualification"
    t.string   "permanent_address"
    t.string   "present_address"
    t.string   "marital_status"
    t.string   "contact_no"
    t.string   "alternate_contact_no"
    t.string   "occupation"
    t.string   "current_income"
    t.string   "working_hrs"
    t.string   "total_exp"
    t.string   "source_of_adv"
    t.string   "submitted_name"
  end

  create_table "orders", force: true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "model"
    t.integer  "price"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.integer  "sub_category_id"
  end

  create_table "sub_categories", force: true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mob_no"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "admin"
    t.string   "city"
    t.string   "state"
    t.string   "pincode"
    t.text     "address"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vacancies", force: true do |t|
    t.string   "post"
    t.string   "experience"
    t.string   "skills"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
