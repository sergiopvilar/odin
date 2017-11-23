class CreateMaps < ActiveRecord::Migration[5.1]
  def change
    create_table :maps do |t|
      t.text :name, null: false
    end

    add_index :maps, :name, unique: true
  end
end
