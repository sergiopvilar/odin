class UpdateDescription < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :description, :text

    file = File.open("#{Rails.root}/db/json/item.json", "rb")
    contents = file.read
    objects = ActiveSupport::JSON.decode(contents)

    objects["items"].each do |i|
      next if i["description"].blank?
      Item.find_by_uid(i["id"]).update_attributes(description: i["description"])
    end
  end
end
