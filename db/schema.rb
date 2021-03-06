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

ActiveRecord::Schema.define(version: 2020_05_10_123650) do

  create_table "animals", force: :cascade do |t|
    t.text "name"
    t.text "outcometype"
    t.text "outcomesubtype"
    t.text "animaltype"
    t.text "sex"
    t.text "breed"
    t.text "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "intake_date"
    t.datetime "outcome_date"
    t.integer "enclosure_id"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "birthday"
    t.index ["enclosure_id"], name: "index_animals_on_enclosure_id"
    t.index ["outcometype"], name: "index_animals_on_outcometype"
  end

  create_table "enclosures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "animal_id"
    t.index ["animal_id"], name: "index_enclosures_on_animal_id"
  end

end
