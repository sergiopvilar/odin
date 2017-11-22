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

ActiveRecord::Schema.define(version: 20171122000934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drops", force: :cascade do |t|
    t.integer "mob_id"
    t.integer "item_id"
    t.float "chance"
  end

  create_table "items", force: :cascade do |t|
    t.integer "uid"
    t.string "name_aegis"
    t.string "name_portuguese"
    t.text "description"
    t.integer "type"
    t.integer "price_buy"
    t.integer "price_sell"
    t.integer "weight"
    t.integer "atk"
    t.integer "defense"
    t.integer "range"
    t.integer "slots"
    t.string "job"
    t.integer "level_required"
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

  create_table "mobs", force: :cascade do |t|
    t.integer "uid"
    t.string "sprite"
    t.string "name_portuguese"
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
    t.string "map"
    t.integer "amount"
    t.integer "delay_start"
    t.integer "delay_end"
  end

end
