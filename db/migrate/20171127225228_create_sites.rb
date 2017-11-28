class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string :domain
      t.string :name
      t.string :site
      t.string :code
      t.integer :rate_exp, default: 1
      t.integer :rate_base, default: 1
      t.integer :drop_common, default: 1
      t.integer :drop_card, default: 1
      t.integer :drop_boss_common, default: 1
      t.integer :drop_boss_card, default: 1
    end
  end
end
