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

ActiveRecord::Schema.define(:version => 20121002180523) do

  create_table "beers", :force => true do |t|
    t.integer  "brewery_id"
    t.string   "name"
    t.float    "abv"
    t.integer  "style_id"
    t.text     "description"
    t.boolean  "discontinued"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "likes_count"
    t.integer  "dislikes_count"
  end

  add_index "beers", ["brewery_id"], :name => "index_beers_on_brewery_id"
  add_index "beers", ["name"], :name => "index_beers_on_name"
  add_index "beers", ["style_id"], :name => "index_beers_on_style_id"

  create_table "breweries", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "closed"
    t.string   "permalink"
    t.string   "website"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "breweries", ["name"], :name => "index_breweries_on_name"
  add_index "breweries", ["permalink"], :name => "index_breweries_on_permalink"

  create_table "recommendable_dislikes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "dislikeable_id"
    t.string   "dislikeable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "recommendable_dislikes", ["dislikeable_id"], :name => "index_recommendable_dislikes_on_dislikeable_id"
  add_index "recommendable_dislikes", ["dislikeable_type"], :name => "index_recommendable_dislikes_on_dislikeable_type"
  add_index "recommendable_dislikes", ["user_id", "dislikeable_id", "dislikeable_type"], :name => "user_dislike_constraint", :unique => true

  create_table "recommendable_ignores", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ignorable_id"
    t.string   "ignorable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "recommendable_ignores", ["ignorable_id"], :name => "index_recommendable_ignores_on_ignorable_id"
  add_index "recommendable_ignores", ["ignorable_type"], :name => "index_recommendable_ignores_on_ignorable_type"
  add_index "recommendable_ignores", ["user_id", "ignorable_id", "ignorable_type"], :name => "user_ignore_constraint", :unique => true

  create_table "recommendable_likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "recommendable_likes", ["likeable_id"], :name => "index_recommendable_likes_on_likeable_id"
  add_index "recommendable_likes", ["likeable_type"], :name => "index_recommendable_likes_on_likeable_type"
  add_index "recommendable_likes", ["user_id", "likeable_id", "likeable_type"], :name => "user_like_constraint", :unique => true

  create_table "recommendable_stashes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "stashable_id"
    t.string   "stashable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "recommendable_stashes", ["stashable_id"], :name => "index_recommendable_stashes_on_stashable_id"
  add_index "recommendable_stashes", ["stashable_type"], :name => "index_recommendable_stashes_on_stashable_type"
  add_index "recommendable_stashes", ["user_id", "stashable_id", "stashable_type"], :name => "user_stashed_constraint", :unique => true

  create_table "styles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "permalink"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "styles", ["permalink"], :name => "index_styles_on_permalink"

  create_table "temp_beers", :force => true do |t|
    t.integer  "brewery_id"
    t.integer  "temp_brewery_id"
    t.string   "name"
    t.float    "abv"
    t.integer  "style_id"
    t.boolean  "discontinued"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "temp_beers", ["style_id"], :name => "index_temp_beers_on_style_id"
  add_index "temp_beers", ["temp_brewery_id"], :name => "index_temp_beers_on_temp_brewery_id"

  create_table "temp_breweries", :force => true do |t|
    t.string   "name"
    t.boolean  "closed"
    t.string   "website"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",               :null => false
    t.string   "email",                  :null => false
    t.string   "password_digest",        :null => false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "likes_count"
    t.integer  "dislikes_count"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
