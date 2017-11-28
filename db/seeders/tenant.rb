class TenantSeeder
  def initialize(tenant)
    @tenant = tenant
    return unless Apartment::Tenant.current == @tenant
    destroy_all
    load_files
    seed_items
    seed_mobs
    seed_drops
    seed_maps
    seed_respawns
    seed_names
  end

  def destroy_all
    puts 'Limpando tabelas'
    Item.destroy_all
    Mob.destroy_all
    Respawn.destroy_all
    Drop.destroy_all
    Map.destroy_all
    MobName.destroy_all
    ItemName.destroy_all
  end

  def load_files
    puts 'Carregando arquivos'
    items_file = File.open("#{Rails.root}/db/json/#{@tenant}/item.json", "rb")
    @items = ActiveSupport::JSON.decode(items_file.read)

    mobs_file = File.open("#{Rails.root}/db/json/#{@tenant}/mob.json", "rb")
    @mobs = ActiveSupport::JSON.decode(mobs_file.read)

    maps_file = File.open("#{Rails.root}/db/json/map.json", "rb")
    @maps = ActiveSupport::JSON.decode(maps_file.read)
  end

  def seed_items
    puts 'Populando itens'
    # Items
    @items["items"].each do |i|
      attributes = {
        uid: i["id"],
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
        level_required: i["nivel_requerido"].to_i,
        weapon_level: i["nivel_arma"],
        refinable: i["refinavel"],
        view: i["view"],
        script: i["script"],
        script_equip: i["script_equip"],
        script_unequip: i["script_desequip"],
        loc: i["loc"]
      }

      item = Item.create(attributes)
      if @tenant == 'public'
        ItemName.create(item_id: item.id, desc_portuguese: i["description"]) unless i["description"].blank?
      end
    end
  end

  def seed_mobs
    puts 'Populando monstros'
    @mobs["mob"].each do |i|
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

      Mob.create(attributes)
    end
  end

  def seed_drops
    puts 'Populando drops'
    # Drops
    @mobs["mob"].each do |i|
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
  end

  def seed_maps
    puts 'Populando mapas'
    # Maps
    @maps["maps"].each do |m|
      Map.create({name: m['map'], desc: m['name']})  if Map.find_by_name(m['map']).blank?
    end
  end

  def seed_respawns
    puts 'Populando respawns'
    # Respawns
    @mobs["mob"].each do |i|
      mob = Mob.find_by_uid(i["ID"])
      next if i["respawn"].blank?
      i["respawn"].each do |map, respawns|
        respawns.each do |delays, amount|
          Respawn.create({
            mob_id: mob.id,
            map_id: Map.find_by_name(map).id,
            amount: amount,
            delay_start: delays.split('_').first,
            delay_end: delays.split('_').last
          })
        end
      end
    end
  end

  def seed_names
    item_names = { item_en: 'name_english', item_pt: 'name_portuguese' }
    mob_names = { mob_en: 'name_english', mob_pt: 'name_portuguese' }

    # Item names
    puts 'Populando nomes dos itens'
    item_names.each do |filename, column|
      file_content = File.read("#{Rails.root}/db/csv/#{filename}.csv")
      csv = CSV.parse(file_content, :headers => true)

      csv.each do |row|
        obj = row.to_hash
        item = Item.find_by_uid(obj["id"])
        next if item.blank?
        attributes = {}
        attributes[column] = obj["name"]
        iname = ItemName.find_or_create_by(item_id: item.id)
        iname.update_attributes(attributes)
      end
    end

    puts 'Populando nomes dos monstros'
    mob_names.each do |filename, column|
      file_content = File.read("#{Rails.root}/db/csv/#{filename}.csv")
      csv = CSV.parse(file_content, :headers => true)

      csv.each do |row|
        obj = row.to_hash
        mob = Mob.find_by_uid(obj["id"])
        next if mob.blank?
        attributes = {}
        attributes[column] = obj["name"]
        iname = MobName.find_or_create_by(mob_id: mob.id)
        iname.update_attributes(attributes)
      end
    end
  end
end
