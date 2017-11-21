class Item < ApplicationRecord
  has_many :drops
  self.inheritance_column = :model_type

  def weapon?
    type == 4
  end

  def armor?
    type == 5
  end

  def ammo?
    type == 10
  end

  def peso
    return (weight.to_f / 10) if weight < 10
    weight / 10
  end

  def full_description
    reserved = ['Defesa:', 'Peso:', 'Classe:', 'Nível da arma:', 'Nível necessário:', 'Profissões que utilizam:',
              'Tipo:', 'Nv. da Arma', 'Nv. Necessário:', 'Classe Aplicável:', 'Tipo de Arma:', 'Equipa em:']
    return '' if description.blank?
    arr = description.split("\n")
                     .reject { |i| reserved.any? { |r| i.starts_with?(r) } }
                     .reject do |line|
                       ActionView::Base.full_sanitizer.sanitize(line).strip.to_i != 0
                      end
    # arr = description.split("\n")
    arr.join('<br />').html_safe
  end

  def name
    return name_portuguese if slots.blank? || slots == 0
    return "#{name_portuguese}[#{slots}]"
  end

  def image
    "/image/item/#{uid}.png"
  end

  def big_image
    "/image/item_big/#{uid}.png"
  end

  def armor_type
    return 'Equipamento para cabeça' if loc == 256 || loc == 512 || loc == 1
    return 'Armadura' if loc == 16
    return 'Arma' if loc == 2
    return 'Escudo' if loc == 32
    return 'Capa' if loc == 4
    return 'Sapatos' if loc == 64
    return 'Acessório' if loc == 8 || loc == 128
  end

  def weapon_type
    types = ['Adaga', 'Espada de uma mão', 'Espada de duas mãos', 'Lança de uma mão', 'Lança de duas mãos',
             'Machado de uma mão', 'Machado de duas mãos', 'Maça', '', 'Cajado', 'Arco', 'Garra', 'Instrumento Musical',
             'Chicote', 'Livro', 'Katar', 'Revólver', 'Rifle', 'Metralhadora', 'Escorpeta', 'Lançador de Granada',
             'Shuriken']
    return types[view.to_i - 1]
  end

  def ammo_type
    types = ['Flecha', 'Adaga lançável', 'Bala', 'Projétil', 'Granada', 'Shuriken', 'Kunai']
    return types[view.to_i - 1]
  end

  def hat?
    loc == 256 || loc == 512 || loc == 1
  end

  def hat_location
    return 'Topo' if loc == 256
    return 'Meio' if loc == 512
    return 'Baixo' if loc == 1
  end

  def job_names
    jobs = {
      'Super Aprendizes': 2**0,
      'Espadachins': 2**1,
      'Magos': 2**2,
      'Arqueiros': 2**3,
      'Noviços': 2**4,
      'Mercadores': 2**5,
      'Gatunos': 2**6,
      'Cavaleiros': 2**7,
      'Sacerdotes': 2**8,
      'Bruxos': 2**9,
      'Ferreiros': 2**10,
      'Caçadores': 2**11,
      'Assasinos': 2**12,
      'unused': 2**13,
      'Templários': 2**14,
      'Monges': 2**15,
      'Sábios': 2**16,
      'Arruaceiros': 2**17,
      'Alquimistas': 2**18,
      'Bardos/Odaliscas': 2**19,
      'unused2': 2**20,
      'Taekwons': 2**21,
      'Mestres Taekwons': 2**22,
      'Espiritualistas': 2**23,
      'Justiceiros': 2**24,
      'Ninjas': 2**25
    }

    denied_jobs = ['unused2', 'unused2', 'Espiritualistas', 'Taekwons', 'Justiceiros', 'Ninjas', 'Mestres Taekwons']

    jobs = Hash[jobs.to_a.reverse]
    job_translated = job.to_i(16)
    used_jobs = get_jobs(jobs, job_translated)
    used_jobs.size == jobs.size ? 'Todas' : used_jobs.compact.delete_if{ |i| denied_jobs.include?(i.to_s) }.join(', ')
  end

  def as_json(options={})
    super(options.merge({:methods => [:image, :name]}))
  end

  private

  def get_jobs(_jobs, rema)
    _jobs.map do |key, value|
      if rema - value < 0
        _jobs.tap { |hs| hs.delete(key) }
        next
      end
      njobs = _jobs.clone
      njobs.tap { |hs| hs.delete(key) }
      ret = get_jobs(njobs, rema - value)
      return [key] + ret
    end
  end

end
