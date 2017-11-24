class AddDescToMap < ActiveRecord::Migration[5.1]
  def change
    add_column :maps, :desc, :string

    maps_file = File.open("#{Rails.root}/db/json/map.json", "rb")
    maps = ActiveSupport::JSON.decode(maps_file.read)

    maps["maps"].each do |m|
      map = Map.find_by_name(m['map'])
      next if map.blank?
      map.update_attributes(desc: m['name'])
    end

  end
end
