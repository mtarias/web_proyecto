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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120629211112) do

  create_table "event_comments", :force => true do |t|
    t.string   "comment"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "event_comments", ["event_id"], :name => "index_event_comments_on_event_id"
  add_index "event_comments", ["user_id"], :name => "index_event_comments_on_user_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "date"
    t.string   "place"
    t.text     "description"
    t.boolean  "is_private"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "group_members", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "group_id"
  end

  add_index "group_members", ["group_id"], :name => "index_group_members_on_group_id"
  add_index "group_members", ["user_id"], :name => "index_group_members_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "group_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "groups", ["user_id"], :name => "index_groups_on_user_id"

  create_table "guests", :force => true do |t|
    t.boolean  "is_going"
    t.boolean  "is_admin"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "guests", ["event_id"], :name => "index_user_events_on_event_id"
  add_index "guests", ["user_id"], :name => "index_user_events_on_user_id"

  create_table "picture_comments", :force => true do |t|
    t.string   "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pictures", :force => true do |t|
    t.string   "name"
    t.string   "path"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.integer  "event_id"
    t.boolean  "is_avatar"
  end

  add_index "pictures", ["event_id"], :name => "index_pictures_on_event_id"
  add_index "pictures", ["user_id"], :name => "index_pictures_on_user_id"

  create_table "taxes", :force => true do |t|
    t.string   "name"
    t.integer  "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "event_id"
  end

  create_table "user_taxes", :force => true do |t|
    t.integer  "amount_user"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "tax_id"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "facebook"
    t.string   "twitter"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "time_zone"
    t.string   "locale"
    t.string   "api_key"
  end

  add_index "users", ["api_key"], :name => "index_users_on_api_key", :unique => true

end
