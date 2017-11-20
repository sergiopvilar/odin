class Item < ApplicationRecord
  has_many :drops
  self.inheritance_column = :model_type

  def weapon?
    type == 4
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

    jobs = Hash[jobs.to_a.reverse]
    job_translated = job.to_i(16)
    used_jobs = get_jobs(jobs, job_translated)
    used_jobs.size == jobs.size ? 'Todas' : used_jobs.compact.delete_if{ |i| i == :unused2 || i == :unused }.join(', ')
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
