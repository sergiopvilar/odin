class CreateItemsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.integer :uid
      t.string :name_aegis
      t.string :name_portuguese
      t.string :description
      t.integer :type
      t.integer :price_buy
      t.integer :price_sell
      t.integer :weight
      t.integer :atk
      t.integer :defense
      t.integer :range
      t.integer :slots
      t.string :job
      t.integer :level_required
      t.integer :upper
      t.integer :sex
      t.integer :weapon_level
      t.integer :refinable
      t.string :view
      t.string :script
      t.string :script_equip
      t.string :script_unequip
    end
  end
end
