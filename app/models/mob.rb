class Mob < ApplicationRecord
  has_many :drops
  has_many :respawns

  def size
    sizes = ['Pequeno', 'Médio', 'Grande']
    sizes[scale-1]
  end

  def image
    "/image/mob/#{uid}.gif"
  end

  def name
    name_portuguese
  end

  def acerto
    level + agi + 20
  end

  def atk_delay
    "#{(adelay.to_f / 1000)}s"
  end

  def esquiva_95
     dex + level + 75
  end

  def race_text
    races = ['Amorfo', 'Morto-Vivo', 'Bruto', 'Planta', 'Inseto', 'Peixe', 'Demônio', 'Humanóide', 'Anjo', 'Dragão',
            'Player']
    races[race]
  end

  def element_text
    ret = ''
    elements = ['Neutro', 'Água', 'Terra', 'Fogo', 'Vento', 'Veneno', 'Sagrado', 'Sombrio', 'Fantasma', 'Maldito']
    levels = {
      '2': '1',
      '4': '2',
      '6': '3',
      '8': '4'
    }
    nivel = levels[:"#{element.to_s.split('').first}"]
    ret += elements[element.to_s.split('').last.to_i]
    ret += " nv. #{nivel}"
  end

  def as_json(options={})
    super(options.merge({:methods => [:image, :name]}))
  end

end
