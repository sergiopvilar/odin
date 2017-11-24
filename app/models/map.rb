class Map < ApplicationRecord
  has_many :respawns

  def image
    "/image/map/#{name}.png"
  end
end
