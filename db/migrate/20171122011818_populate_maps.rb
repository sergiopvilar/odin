class PopulateMaps < ActiveRecord::Migration[5.1]
  def change
    maps = Respawn.all.map{ |respawn| respawn.map }.uniq

    maps.each do |map|
      Map.create(name: map)
    end
  end
end
