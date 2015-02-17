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

ActiveRecord::Schema.define(version: 20150217144701) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attributions", force: :cascade do |t|
    t.integer  "misquotable_id"
    t.string   "text"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "altered_text"
  end

  create_table "misquotables", force: :cascade do |t|
    t.integer  "npr_id"
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pos_tags", force: :cascade do |t|
    t.string   "tag"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "example"
  end

  create_table "quotes", force: :cascade do |t|
    t.integer  "misquotable_id"
    t.text     "text"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "altered_text"
  end

  create_table "titles", force: :cascade do |t|
    t.integer  "misquotable_id"
    t.string   "text"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "altered_text"
  end

  create_table "words", force: :cascade do |t|
    t.string   "text"
    t.string   "pos_tag_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "token_id"
    t.string   "token_type"
    t.boolean  "replace?",    default: false
    t.string   "replacement"
    t.boolean  "repeat?",     default: false
  end

  add_index "words", ["token_type", "token_id"], name: "index_words_on_token_type_and_token_id", using: :btree

end
