class CreateRagnaGg < ActiveRecord::Migration[5.1]
  def change
    Site.create(
      code: 'gg',
      domain: Rails.env.development? ? 'ragnagg.odinlocal.com' : 'ragnagg.odindb.com',
      name: 'RagnaGG',
      site: 'http://ragnagg.com',
      rate_exp: 7,
      rate_base: 7,
      drop_common: 5,
      drop_card: 3,
      drop_boss_common: 3,
      drop_boss_card: 1
    )
  end
end
