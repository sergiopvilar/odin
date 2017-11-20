require 'byebug'

jobs = {
  'super_novice': 2**0,
  'swordman': 2**1,
  'mage': 2**2,
  'archer': 2**3,
  'acolyte': 2**4,
  'merchant': 2**5,
  'thief': 2**6,
  'knight': 2**7,
  'priest': 2**8,
  'wizard': 2**9,
  'blacksmith': 2**10,
  'hunter': 2**11,
  'assassin': 2**12,
  'unused': 2**13,
  'crusader': 2**14,
  'monk': 2**15,
  'sage': 2**16,
  'rogue': 2**17,
  'alchemist': 2**18,
  'bard_dancer': 2**19,
  'unused2': 2**20,
  'taekwon': 2**21,
  'star_gladiator': 2**22,
  'soul_linker': 2**23,
  'gunslinger': 2**24,
  'ninja': 2**25
}

jobs = Hash[jobs.to_a.reverse]

# equip = "0x00004082".to_i(16)
# equip = "0x000ED5F2".to_i(16)
equip = "0xFFFFFFFF".to_i(16)

def fetch(_jobs, rema)
  _jobs.map do |key, value|
    if rema - value < 0
      _jobs.tap { |hs| hs.delete(key) }
      next
    end
    njobs = _jobs.clone
    njobs.tap { |hs| hs.delete(key) }
    ret = fetch(njobs, rema - value)
    return [key] + ret
  end
end

puts fetch(jobs, equip).compact.delete_if{ |i| i == :unused2 || i == :unused }.to_s
