class PopulateRespawns < ActiveRecord::Migration[5.1]
  def change
    file = File.open("#{Rails.root}/db/json/mob.json", "rb")
    contents = file.read
    objects = ActiveSupport::JSON.decode(contents)

    objects["mob"].each do |i|
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
  end
end
