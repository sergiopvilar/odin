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

ActiveRecord::Schema.define(version: 20171127232720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drops", force: :cascade do |t|
    t.integer "mob_id"
    t.integer "item_id"
    t.float "chance"
  end

  create_table "item_names", force: :cascade do |t|
    t.integer "item_id"
    t.string "name_portuguese"
    t.string "name_english"
    t.text "desc_portuguese"
    t.text "desc_english"
  end

  create_table "items", force: :cascade do |t|
    t.integer "uid"
    t.integer "type"
    t.integer "price_buy"
    t.integer "price_sell"
    t.integer "weight"
    t.integer "atk"
    t.integer "defense"
    t.integer "range"
    t.integer "slots"
    t.string "job"
    t.integer "level_required", default: 1
    t.integer "upper"
    t.integer "sex"
    t.integer "weapon_level"
    t.integer "refinable"
    t.string "view"
    t.string "script"
    t.string "script_equip"
    t.string "script_unequip"
    t.integer "loc"
  end

  create_table "maps", force: :cascade do |t|
    t.text "name", null: false
    t.string "desc"
    t.index ["name"], name: "index_maps_on_name", unique: true
  end

  create_table "mob_names", force: :cascade do |t|
    t.integer "mob_id"
    t.string "name_portuguese"
    t.string "name_english"
  end

  create_table "mobs", force: :cascade do |t|
    t.integer "uid"
    t.string "sprite"
    t.integer "level"
    t.integer "hp"
    t.integer "sp"
    t.integer "exp"
    t.integer "job_exp"
    t.integer "range"
    t.integer "atk1"
    t.integer "atk2"
    t.integer "def"
    t.integer "mdef"
    t.integer "str"
    t.integer "agi"
    t.integer "vit"
    t.integer "dex"
    t.integer "luk"
    t.integer "int"
    t.integer "range2"
    t.integer "range3"
    t.integer "scale"
    t.integer "race"
    t.integer "element"
    t.integer "speed"
    t.integer "adelay"
    t.integer "admotion"
    t.integer "dmotion"
    t.string "mode"
  end

  create_table "respawns", force: :cascade do |t|
    t.integer "mob_id"
    t.integer "amount"
    t.integer "delay_start"
    t.integer "delay_end"
    t.integer "map_id"
    t.index ["map_id"], name: "index_respawns_on_map_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "domain"
    t.string "name"
    t.string "site"
    t.string "code"
    t.integer "rate_exp", default: 1
    t.integer "rate_base", default: 1
    t.integer "drop_common", default: 1
    t.integer "drop_card", default: 1
    t.integer "drop_boss_common", default: 1
    t.integer "drop_boss_card", default: 1
  end

end
