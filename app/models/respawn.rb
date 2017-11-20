class Respawn < ApplicationRecord
  belongs_to :mob

  def tempo
    return '' if (delay_start/(60 * 1000)) <= 0
    return " a cada #{delay_start/(60 * 1000)} minutos" if (delay_end/(60 * 1000)) <= 0
    return " a cada #{delay_end/(60 * 1000)} ~ #{delay_start/(60 * 1000)} minutos"
  end
end
