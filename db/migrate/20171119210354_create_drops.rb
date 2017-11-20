class CreateDrops < ActiveRecord::Migration[5.1]
  def change
    create_table :drops do |t|
      t.integer :mob_id
      t.integer :item_id
      t.float :chance
    end
  end
end
