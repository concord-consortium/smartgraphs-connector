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

ActiveRecord::Schema.define(:version => 20120713213401) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.string   "publication_status"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "embeddable_multiple_choice_choices", :force => true do |t|
    t.integer  "multiple_choice_id"
    t.text     "choice"
    t.boolean  "is_correct"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "embeddable_multiple_choices", :force => true do |t|
    t.string   "name"
    t.text     "prompt"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "embeddable_open_responses", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "prompt"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "external_activities", :force => true do |t|
    t.integer  "template_id"
    t.string   "template_type"
    t.string   "name"
    t.integer  "user_id"
    t.text     "url"
    t.boolean  "append_learner_id_to_url"
    t.boolean  "popup"
    t.string   "publication_status"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "page_elements", :force => true do |t|
    t.integer  "page_id"
    t.integer  "embeddable_id"
    t.string   "embeddable_type"
    t.integer  "position"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "pages", :force => true do |t|
    t.integer  "section_id"
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "portal_learners", :force => true do |t|
    t.integer  "offering_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "portal_offerings", :force => true do |t|
    t.integer  "runnable_id"
    t.string   "runnable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "saveable_multiple_choice_answers", :force => true do |t|
    t.integer  "multiple_choice_id"
    t.integer  "choice_id"
    t.integer  "position"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "saveable_multiple_choices", :force => true do |t|
    t.integer  "learner_id"
    t.integer  "offering_id"
    t.integer  "multiple_choice_id"
    t.integer  "response_count",     :default => 0
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "saveable_open_response_answers", :force => true do |t|
    t.integer  "open_response_id"
    t.integer  "position"
    t.text     "answer"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "saveable_open_responses", :force => true do |t|
    t.integer  "learner_id"
    t.integer  "offering_id"
    t.integer  "open_response_id"
    t.integer  "response_count",   :default => 0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "sections", :force => true do |t|
    t.integer  "activity_id"
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "smartgraphs_connector_persistences", :force => true do |t|
    t.integer  "learner_id"
    t.text     "content",    :limit => 8388607
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "smartgraphs_connector_persistences", ["learner_id"], :name => "sg_connector_learner_idx"

end
