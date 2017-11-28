class Drop < ApplicationRecord
  belongs_to :mob
  belongs_to :item

  def real_chance
    real_chance = get_real_chance
    real_chance > 100 ? 100 : real_chance.round(2)
  end

  def get_real_chance
    return chance if Apartment::Tenant.current == 'public'
    site = Site.find_by_code(Apartment::Tenant.current)
    return chance * site.drop_card if !mob.boss_droper? && item.card?
    return chance * site.drop_boss_card if mob.boss_droper? && item.card?
    return chance * site.drop_common if !mob.boss_droper? && !item.card?
    return chance * site.drop_boss_common if mob.boss_droper? && !item.card?
    return chance
  end

end
