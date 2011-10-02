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

ActiveRecord::Schema.define(:version => 20110915120809) do

  create_table "comment_votes", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "comment_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comment_votes", ["user_id", "comment_id"], :name => "index_comment_votes_on_user_id_and_comment_id", :unique => true

  create_table "comments", :force => true do |t|
    t.integer  "user_id",                           :null => false
    t.integer  "debate_question_id",                :null => false
    t.integer  "counter",            :default => 0, :null => false
    t.string   "body",                              :null => false
    t.integer  "vote",               :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "debate_questions", :force => true do |t|
    t.integer  "user_id"
    t.string   "body",                         :null => false
    t.integer  "yes_count",     :default => 0
    t.integer  "no_count",      :default => 0
    t.integer  "neutral_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "debate_votes", :force => true do |t|
    t.integer  "user_id",            :null => false
    t.integer  "debate_question_id", :null => false
    t.integer  "current_vote",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "screen_name"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
