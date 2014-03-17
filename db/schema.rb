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

ActiveRecord::Schema.define(version: 20140316024544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "num_answers"
    t.integer  "reportdate_id"
    t.integer  "respondent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "overalls", force: true do |t|
    t.date     "date"
    t.integer  "desk"
    t.integer  "getsat"
    t.integer  "usergrid"
    t.integer  "feedback"
    t.integer  "appcraft"
    t.integer  "stackoverflow"
    t.integer  "help"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "overallstatsold", id: false, force: true do |t|
    t.date    "date",          null: false
    t.integer "desk",          null: false
    t.integer "stackoverflow", null: false
    t.integer "getsat",        null: false
    t.integer "appcraft",      null: false
    t.integer "usergrid",      null: false
    t.integer "feedback",      null: false
    t.integer "help",          null: false
  end

  create_table "reportdates", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "questions"
    t.integer  "views"
    t.integer  "num_answers"
  end

  create_table "respondents", force: true do |t|
    t.string   "name"
    t.string   "display_name"
    t.string   "employee"
    t.string   "full_name"
    t.string   "department"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
