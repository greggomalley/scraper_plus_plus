# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_10_07_143225) do
  create_table "schedules", force: :cascade do |t|
    t.text "name"
    t.text "cron"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scrape_rule_groups", force: :cascade do |t|
    t.integer "scrape_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scrape_id"], name: "index_scrape_rule_groups_on_scrape_id"
  end

  create_table "scrape_rules", force: :cascade do |t|
    t.text "xpath"
    t.text "key"
    t.integer "scrape_rule_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scrape_rule_group_id"], name: "index_scrape_rules_on_scrape_rule_group_id"
  end

  create_table "scrapes", force: :cascade do |t|
    t.text "name"
    t.text "url"
    t.text "format"
    t.text "ref"
    t.integer "retries"
    t.integer "status"
    t.datetime "last_synced_at"
    t.integer "schedule_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_scrapes_on_schedule_id"
  end

  add_foreign_key "scrape_rule_groups", "scrapes", on_delete: :cascade
  add_foreign_key "scrape_rules", "scrape_rule_groups", on_delete: :cascade
  add_foreign_key "scrapes", "schedules", on_delete: :cascade
end
