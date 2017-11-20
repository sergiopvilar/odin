class CreateMobTable < ActiveRecord::Migration[5.1]
  def change
    create_table :mobs do |t|
      t.integer :uid
      t.string :sprite
      t.string :name_portuguese
      t.integer :level
      t.integer :hp
      t.integer :sp
      t.integer :exp
      t.integer :job_exp
      t.integer :range
      t.integer :atk1
      t.integer :atk2
      t.integer :def
      t.integer :mdef
      t.integer :str
      t.integer :agi
      t.integer :vit
      t.integer :dex
      t.integer :luk
      t.integer :int
      t.integer :range2
      t.integer :range3
      t.integer :scale
      t.integer :race
      t.integer :element
      t.integer :speed
      t.integer :adelay
      t.integer :admotion
      t.integer :dmotion
    end
  end
end
