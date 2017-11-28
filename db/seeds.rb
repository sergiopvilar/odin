# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require_relative 'seeders/tenant'

ItemName.destroy_all if Apartment::Tenant.current == 'public'

tenants = ['public']
tenants << Site.all.pluck(:code)
tenants.flatten.each { |tenant| TenantSeeder.new(tenant) }

if Apartment::Tenant.current == 'public'
  MobName.destroy_all
  
  item_names = { item_en: 'name_english', item_pt: 'name_portuguese' }
  mob_names = { mob_en: 'name_english', mob_pt: 'name_portuguese' }

  # Item names
  puts 'Populando nomes dos itens'
  item_names.each do |filename, column|
    file_content = File.read("#{Rails.root}/db/csv/#{filename}.csv")
    csv = CSV.parse(file_content, :headers => true)

    csv.each do |row|
      obj = row.to_hash
      item = Item.find_by_uid(obj["id"])
      next if item.blank?
      attributes = {}
      attributes[column] = obj["name"]
      iname = ItemName.find_or_create_by(item_id: item.id)
      iname.update_attributes(attributes)
    end
  end

  puts 'Populando nomes dos monstros'
  mob_names.each do |filename, column|
    file_content = File.read("#{Rails.root}/db/csv/#{filename}.csv")
    csv = CSV.parse(file_content, :headers => true)

    csv.each do |row|
      obj = row.to_hash
      mob = Mob.find_by_uid(obj["id"])
      next if mob.blank?
      attributes = {}
      attributes[column] = obj["name"]
      iname = MobName.find_or_create_by(mob_id: mob.id)
      iname.update_attributes(attributes)
    end
  end
end
