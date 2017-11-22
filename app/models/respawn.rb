class Respawn < ApplicationRecord
  belongs_to :mob

  def tempo
    return 'Instantaneamente' if (delay_start/(60 * 1000)) <= 0
    return "#{delay_start/(60 * 1000)} minutos" if (delay_end/(60 * 1000)) <= 0
    return "#{delay_end/(60 * 1000)} ~ #{delay_start/(60 * 1000)} minutos"
  end
end
