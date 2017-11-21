class AddLocToItens < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :loc, :integer

    file = File.open("#{Rails.root}/db/json/item.json", "rb")
    contents = file.read
    objects = ActiveSupport::JSON.decode(contents)

    objects["items"].each do |i|
      Item.find_by_uid(i["id"]).update_attributes(loc: i["loc"])
    end
  end
end
