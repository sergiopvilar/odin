class CreateMobNames < ActiveRecord::Migration[5.1]
  def change
    create_table :mob_names do |t|
      t.integer :mob_id
      t.string :name_portuguese
      t.string :name_english
    end
  end
end
