class PopulateDrops < ActiveRecord::Migration[5.1]
  def change
    file = File.open("#{Rails.root}/db/json/mob.json", "rb")
    contents = file.read
    objects = ActiveSupport::JSON.decode(contents)

    objects["mob"].each do |i|
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
end
