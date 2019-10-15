# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_15_134433) do

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "title"
    t.string "link"
  end

  create_table "episodes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "episode_name"
    t.bigint "season_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["season_id"], name: "index_episodes_on_season_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "product"
    t.string "location"
    t.string "status"
    t.string "investors"
    t.string "kitna"
    t.bigint "episode_id", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["episode_id"], name: "index_products_on_episode_id"
  end

  create_table "seasons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "season"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "socials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "social"
    t.bigint "product_id", null: false
    t.index ["product_id"], name: "index_socials_on_product_id"
  end

  add_foreign_key "episodes", "seasons"
  add_foreign_key "products", "companies"
  add_foreign_key "products", "episodes"
  add_foreign_key "socials", "products"
end
