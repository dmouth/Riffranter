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

ActiveRecord::Schema.define(:version => 20110613001205) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], :name => "index_categories_on_name"

  create_table "categories_personas", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "persona_id"
  end

  add_index "categories_personas", ["persona_id", "category_id"], :name => "index_categories_personas_on_persona_id_and_category_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "personas", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personas_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "persona_id"
  end

  add_index "personas_users", ["persona_id", "user_id"], :name => "index_personas_users_on_persona_id_and_user_id"

  create_table "rants", :force => true do |t|
    t.integer  "user_id"
    t.integer  "persona_id"
    t.text     "body"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rants", ["persona_id"], :name => "index_rants_on_persona_id"
  add_index "rants", ["user_id"], :name => "index_rants_on_user_id"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.string   "image"
    t.string   "handle"
    t.boolean  "send_mail_updates"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["handle"], :name => "index_users_on_handle"
  add_index "users", ["send_mail_updates"], :name => "index_users_on_send_mail_updates"

  create_table "users_users", :id => false, :force => true do |t|
    t.integer "follower_id"
    t.integer "followee_id"
  end

  add_index "users_users", ["follower_id", "followee_id"], :name => "index_users_users_on_follower_id_and_followee_id"

  create_table "votes", :force => true do |t|
    t.integer  "rant_id"
    t.integer  "user_id"
    t.integer  "stars"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["rant_id"], :name => "index_votes_on_rant_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
