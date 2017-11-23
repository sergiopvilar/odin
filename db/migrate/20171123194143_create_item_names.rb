class CreateItemNames < ActiveRecord::Migration[5.1]
  def change
    create_table :item_names do |t|
      t.integer :item_id
      t.string :name_portuguese
      t.string :name_english
      t.text :desc_portuguese
      t.text :desc_english
    end
  end
end
