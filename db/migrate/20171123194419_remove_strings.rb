class RemoveStrings < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :name_aegis
    remove_column :items, :name_english
    remove_column :items, :name_portuguese
    remove_column :items, :description

    remove_column :mobs, :name_english
    remove_column :mobs, :name_portuguese
  end
end
