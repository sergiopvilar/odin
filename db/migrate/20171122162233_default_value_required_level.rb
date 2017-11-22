class DefaultValueRequiredLevel < ActiveRecord::Migration[5.1]
  def change
    change_column_default :items, :level_required, 1
    Item.find_each do |item|
      if item.level_required.nil?
        item.level_required = 1
        item.save
      end
    end
  end
end
