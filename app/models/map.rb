class Map < ApplicationRecord
  has_many :respawns

  def image
    "/image/map/#{name}.png"
  end

  def self.results_for(term)
    Map.where("lower(name) LIKE ?", "%#{term.downcase}%")
       .or(Map.where("lower(maps.desc) LIKE ?", "%#{term.downcase}%"))
       .or(Map.where("lower(sem_acento(maps.desc)) ILIKE ?", "%#{term.downcase}%"))
  end
end
