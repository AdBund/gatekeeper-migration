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

ActiveRecord::Schema.define(version: 20170212145711) do

  create_table "api_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "token",                       null: false
    t.string  "userId",                      null: false
    t.string  "username"
    t.string  "password"
    t.boolean "initialized", default: false
    t.integer "provider_id"
    t.index ["provider_id", "token", "userId", "username", "password"], name: "unique_provider_token", unique: true, using: :btree
    t.index ["provider_id"], name: "index_api_tokens_on_provider_id", using: :btree
    t.index ["token"], name: "index_api_tokens_on_token", using: :btree
  end

  create_table "campaigns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "campaign_identity", null: false
    t.string  "name"
    t.integer "api_token_id"
    t.integer "provider_id"
    t.index ["api_token_id"], name: "index_campaigns_on_api_token_id", using: :btree
    t.index ["provider_id", "campaign_identity", "api_token_id"], name: "unique_campaign", unique: true, using: :btree
    t.index ["provider_id"], name: "index_campaigns_on_provider_id", using: :btree
  end

  create_table "providers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_providers_on_name", unique: true, using: :btree
  end

  create_table "statistics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "click",                   default: 0
    t.integer "impression",              default: 0
    t.float   "cost",         limit: 24, default: 0.0
    t.integer "conversion",              default: 0
    t.date    "date"
    t.integer "provider_id"
    t.integer "campaign_id"
    t.integer "api_token_id"
    t.index ["api_token_id"], name: "index_statistics_on_api_token_id", using: :btree
    t.index ["campaign_id", "date", "provider_id", "api_token_id"], name: "unique_daily_report", unique: true, using: :btree
    t.index ["campaign_id"], name: "index_statistics_on_campaign_id", using: :btree
    t.index ["provider_id"], name: "index_statistics_on_provider_id", using: :btree
  end

  add_foreign_key "api_tokens", "providers", on_delete: :nullify
  add_foreign_key "campaigns", "api_tokens", on_delete: :nullify
  add_foreign_key "campaigns", "providers", on_delete: :nullify
  add_foreign_key "statistics", "api_tokens", on_delete: :nullify
  add_foreign_key "statistics", "campaigns", on_delete: :nullify
  add_foreign_key "statistics", "providers", on_delete: :nullify
end
