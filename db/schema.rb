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

ActiveRecord::Schema.define(version: 2018_12_24_074316) do

  create_table "basic_indices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "per"
    t.float "pbr"
    t.bigint "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_basic_indices_on_stock_id"
  end

  create_table "basic_informations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "market_capitalization"
    t.float "dividend_yield"
    t.float "stock_price"
    t.string "overview"
    t.string "url"
    t.string "kind_of_industry"
    t.bigint "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_basic_informations_on_stock_id"
  end

  create_table "financial_informations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "net_income"
    t.float "total_assets"
    t.float "net_worth"
    t.bigint "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_financial_informations_on_stock_id"
  end

  create_table "masic_formulas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "roa_rank"
    t.integer "per_rank"
    t.integer "masic_formula_rank"
    t.bigint "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "basic_index_id"
    t.integer "various_index_id"
    t.index ["masic_formula_rank"], name: "index_masic_formulas_on_masic_formula_rank"
    t.index ["stock_id"], name: "index_masic_formulas_on_stock_id"
  end

  create_table "operating_incomes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "next_fiscal_operating_income"
    t.float "operating_income_for_this_fiscal_year"
    t.float "privious_year_operating_income"
    t.float "operating_income_two_fiscal_year_before"
    t.bigint "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_operating_incomes_on_stock_id"
  end

  create_table "sales", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "next_fiscal_sales"
    t.float "sales_for_this_fiscal_year"
    t.float "privious_year_sales"
    t.float "sales_two_fiscal_year_before"
    t.bigint "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_sales_on_stock_id"
  end

  create_table "stocks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "securities_code"
    t.string "corp_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "favorite"
    t.index ["favorite"], name: "index_stocks_on_favorite"
  end

  create_table "various_indices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "roe"
    t.float "roa"
    t.float "sales_growth_rate"
    t.float "operating_income_growth_rate"
    t.bigint "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_various_indices_on_stock_id"
  end

  add_foreign_key "basic_indices", "stocks"
  add_foreign_key "basic_informations", "stocks"
  add_foreign_key "financial_informations", "stocks"
  add_foreign_key "masic_formulas", "stocks"
  add_foreign_key "operating_incomes", "stocks"
  add_foreign_key "sales", "stocks"
  add_foreign_key "various_indices", "stocks"
end
