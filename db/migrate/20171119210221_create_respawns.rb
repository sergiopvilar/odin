class CreateRespawns < ActiveRecord::Migration[5.1]
  def change
    create_table :respawns do |t|
      t.integer :mob_id
      t.string :map
      t.integer :amount
      t.integer :delay_start
      t.integer :delay_end
    end
  end
end
