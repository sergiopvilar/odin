class Drop < ApplicationRecord
  belongs_to :mob
  belongs_to :item

  def real_chance
    chance
  end

end
