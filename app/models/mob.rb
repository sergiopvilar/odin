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

  def description
    "HP: #{hp} | Raça: #{race_text} | Tamanho: #{size} | Propriedade: #{element_text}"
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

  def elemental_table
    file = File.open("#{Rails.root}/db/json/elements.json", "rb")
    contents = file.read
    objects = ActiveSupport::JSON.decode(contents)
    objects[element_text(true)]
  end

  def mode_text
    modes = {
      '0x0081': 'Passivo',
      '0x0083': 'Passivo / Coletor',
      '0x1089': 'Passivo / Ajuda outros / Muda de Alvo / Corpo-a-corpo',
      '0x3885': 'Agressivo / Muda de Alvo / Corpo-a-corpo / Persegue',
      '0x2085': 'Agressivo / Muda de Alvo / Persegue',
      '0x0000': 'Passivo / Imóvel / Não ataca',
      '0x108B': 'Passivo / Coletor / Ajuda outros / Muda de Alvo / Corpo-acorpo',
      '0x7085': 'Agressivo / Muda de alvo / Persegue / Prefere alvos fracos',
      '0x3095': 'Agressivo / Muda de alvo / Corpo-a-corpo / Persegue / Detecta cast',
      '0x0084': 'Agressivo / Imóvel',
      '0x0084': 'Agressivo / Imóvel',
      '0x2085': 'Agressivo / Muda de Alvo / Persegue',
      '0x308D': 'Agressivo / Muda de Alvo / Corpo-a-corpo / Persegue / Ajuda outros',
      '0x0091': 'Passivo / Sensor de cast',
      '0x3095': 'Agressivo / Muda de Alvo / Corpo-a-corpo / Persegue / Detecta cast',
      '0x3295': 'Agressivo / Muda de Alvo / Corpo-a-corpo / Persegue / Detecta cast e persegue',
      '0x3695': 'Agressivo / Muda de Alvo / Corpo-a-corpo / Persegue / Detecta cast e persegue / Muda alvo da perseguição',
      '0x00A1': 'Passivo / Não anda aleatoriamente',
      '0x0001': 'Passivo / Não ataca',
      '0xB695': 'Agressivo / Muda de Alwo / Corpo-a-corpo / Persegue / Detecta cast / Alvo aleatório',
      '0x8084': 'Agressivo / Imóvel / Alvo aleatório',
    }

    return '' unless modes.key?(mode.to_sym)
    return modes[mode.to_sym]
  end

  def element_text(slug = false)
    ret = ''
    elements_slug = ['neutral', 'water', 'earth', 'fire', 'wind', 'poison', 'holy', 'shadow', 'ghost', 'undead']
    elements = ['Neutro', 'Água', 'Terra', 'Fogo', 'Vento', 'Veneno', 'Sagrado', 'Sombrio', 'Fantasma', 'Maldito']
    levels = {
      '2': '1',
      '4': '2',
      '6': '3',
      '8': '4'
    }
    nivel = levels[:"#{element.to_s.split('').first}"]

    if slug
      ret += elements_slug[element.to_s.split('').last.to_i]
      ret += "_#{nivel}"
    else
      ret += elements[element.to_s.split('').last.to_i]
      ret += " nv. #{nivel}"
    end

  end

  def as_json(options={})
    super(options.merge({:methods => [:image, :name]}))
  end

end
