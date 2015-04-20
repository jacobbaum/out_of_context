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

ActiveRecord::Schema.define(version: 20150419174122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "misquotables", force: :cascade do |t|
    t.integer  "npr_id"
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "topic_id"
    t.integer  "user_id"
  end

  create_table "misquotes", force: :cascade do |t|
    t.integer  "npr_id"
    t.string   "link"
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "search_term"
  end

  create_table "pos_tags", force: :cascade do |t|
    t.string   "tag"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "example"
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "misquotable_id"
    t.string   "name"
    t.text     "text"
    t.text     "altered_text"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "misquote_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.integer  "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  create_table "words", force: :cascade do |t|
    t.string   "text"
    t.string   "pos_tag_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "replace?",    default: false
    t.string   "replacement"
    t.boolean  "repeat?",     default: false
    t.integer  "section_id"
  end

end
