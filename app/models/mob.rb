class Mob < ApplicationRecord
  has_many :drops
  has_many :respawns
  has_one :mob_name

  def self.with_respawn
    Mob.includes(:respawns).where.not(respawns: { id: nil })
  end

  def size
    sizes = ['Pequeno', 'Médio', 'Grande']
    sizes[scale-1]
  end

  def image
    "/image/mob/#{uid}.gif"
  end

  def name
    mob_name.name_portuguese.blank? ? mob_name.name_english : mob_name.name_portuguese
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

  def aspd
    delay = adelay.to_f / 1000
    hps = 1/delay
    (((200 * hps) - 50) / hps).to_i
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
    return search_for_mode(mode.to_i) if mode.to_i != 0
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

    return '' if mode.blank? || !modes.key?(mode.to_sym)
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

  def self.results_for(term)

    mob_by_uid = Mob.where(uid: term).includes(:respawns)
    return mob_by_uid if mob_by_uid.any?

    mob_ids = MobName.where("lower(name_portuguese) LIKE ?", "%#{term.downcase}%")
                     .or(MobName.where("lower(name_english) LIKE ?", "%#{term.downcase}%"))
                     .or(MobName.where("lower(sem_acento(name_portuguese)) ILIKE ?", "%#{term.downcase}%"))
                     .pluck(:mob_id)
    Mob.with_respawn.includes(:respawns).where(id: mob_ids)
  end

  def search_for_mode(mode)
    modes = {
      'CAN_MOVE': 1,
      'Coletor': 2,
      'Agressivo': 4,
      'Ajuda outros': 8,
      'Detecta cast': 16,
      'Não anda aleatoriamente': 32,
      'Não utiliza habilidades': 64,
      'Ataca de volta': 128,
      '': 256,
      'Detecta cast e muda de alvo': 512,
      'Muda de alvo': 1024,
      'Irridadiço': 2048,
      'Muda de alvo ao ser atacado fisicamente': 4096,
      'Muda de alvo em perseguição': 8192,
      'Prefere alvos mais fracos': 16384,
      'Alvo aleatório': 32768,
      'Ignora atacantes físicos': 65536,
      'Ignora atacantes mágicos': 131072,
      'Ignora atacantes a distância': 262144,
      'MVP': 524288,
      'Toma apenas "1" de dano': 1048576,
      'Não pode ser empurrado': 2097152,
      '': 4194304,
      '': 8388608,
      'Drops não são afetados por consumíveis': 16777216,
      'Detecta em esconderijo': 33554432,
      'Imune a status negativos': 67108864,
      'Imune a habilidades': 134217728
    }

    modes = Hash[modes.to_a.reverse]
    mob_modes = get_modes(modes, mode).compact
    mob_modes.push('Não se move') unless mob_modes.include?(:CAN_MOVE)
    mob_modes.delete_if{ |i| i.blank? || i == :CAN_MOVE }.join(', ')
  end

  private

  def get_modes(_jobs, rema)
    _jobs.map do |key, value|
      if rema - value < 0
        _jobs.tap { |hs| hs.delete(key) }
        next
      end
      njobs = _jobs.clone
      njobs.tap { |hs| hs.delete(key) }
      ret = get_modes(njobs, rema - value)
      return [key] + ret
    end
  end

end
