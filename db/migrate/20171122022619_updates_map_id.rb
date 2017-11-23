class UpdatesMapId < ActiveRecord::Migration[5.1]
  def change
    Respawn.all.each do |respawn|
      respawn.update_attributes(map_id: Map.find_by_name(respawn.attributes['map']).id)
    end

    remove_column :respawns, :map
  end
end
