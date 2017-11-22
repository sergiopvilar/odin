class AddModeToMob < ActiveRecord::Migration[5.1]
  def change
    add_column :mobs, :mode, :string

    file = File.open("#{Rails.root}/db/json/mob.json", "rb")
    contents = file.read
    objects = ActiveSupport::JSON.decode(contents)

    objects["mob"].each do |i|
      mob = Mob.find_by_uid(i["ID"].to_i)
      next if mob.blank?
      mob.update_attributes(mode: i["Mode"])
    end
  end
end
