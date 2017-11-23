class AddsMapId < ActiveRecord::Migration[5.1]
  def change
    add_reference :respawns, :map, type: :integer, index: true
  end
end
