# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Reset
Item.destroy_all
Mob.destroy_all
Respawn.destroy_all
Drop.destroy_all

# Files
items_file = File.open("#{Rails.root}/db/json/#{ENV['DB_VERSION']}/item.json", "rb")
items = ActiveSupport::JSON.decode(items_file.read)

mobs_file = File.open("#{Rails.root}/db/json/#{ENV['DB_VERSION']}/mob.json", "rb")
mobs = ActiveSupport::JSON.decode(mobs_file.read)

# Items
items["items"].each do |i|
  attributes = {
    uid: i["id"],
    name_aegis: i["nome_aegis"],
    type: i["tipo"],
    price_buy: i["valor_compra"],
    price_sell: i["valor_venda"],
    weight: i["peso"],
    atk: i["atk"],
    defense: i["def"],
    range: i["alcance"],
    slots: i["slots"],
    upper: i["uper"],
    sex: i["sexo"],
    job: i["classe"],
    level_required: i["nivel_requerido"],
    weapon_level: i["nivel_arma"],
    refinable: i["refinavel"],
    view: i["view"],
    script: i["script"],
    script_equip: i["script_equip"],
    script_unequip: i["script_desequip"],
    loc: i["loc"]
  }

  attributes[:description] = i["description"] unless i["description"].blank?
  attributes[:name_portuguese] = i["nome"] unless i["nome"].blank?
  attributes[:name_english] = i["nome_english"] unless i["nome_english"].blank?
  Item.create(attributes)
end

mobs["mob"].each do |i|
  attributes = {
    uid: i["ID"],
    sprite: i["Sprite_Name"],
    level: i["LV"],
    hp: i["HP"],
    sp: i["SP"],
    exp: i["EXP"],
    job_exp: i["JEXP"],
    range: i["Range1"],
    atk1: i["ATK1"],
    atk2: i["ATK2"],
    def: i["DEF"],
    mdef: i["MDEF"],
    str: i["STR"],
    int: i["INT"],
    agi: i["AGI"],
    vit: i["VIT"],
    dex: i["DEX"],
    luk: i["LUK"],
    range2: i["Range2"],
    range3: i["Range3"],
    scale: i["Scale"],
    race: i["Race"],
    element: i["Element"],
    speed: i["Speed"],
    adelay: i["aDelay"],
    admotion: i["aMotion"],
    dmotion: i["dMotion"],
    mode: i["Mode"]
  }

  attributes[ENV['DB_VERSION'] == 'ep_4' ? :name_english : :name_portuguese] = i["kROName"]
  puts "Creating #{i["ID"]}: #{i["kROName"]}"
  Mob.create(attributes)
end

# Drops
mobs["mob"].each do |i|
  mob = Mob.find_by_uid(i["ID"])
  i["drops"].each do |key, chance|
    item = Item.find_by_uid(key)
    Drop.create({
      item_id: item.id,
      mob_id: mob.id,
      chance: chance
    })
  end
end

# Respawns
mobs["mob"].each do |i|
  mob = Mob.find_by_uid(i["ID"])
  next if i["respawn"].blank?
  i["respawn"].each do |map, respawns|
    respawns.each do |delays, amount|
      Respawn.create({
        mob_id: mob.id,
        map: map,
        amount: amount,
        delay_start: delays.split('_').first,
        delay_end: delays.split('_').last
      })
    end
  end
end
