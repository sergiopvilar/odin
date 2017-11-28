namespace :db do
  desc "TODO"
  task functions: :environment do
    tenants = ['public']
    tenants << Site.all.pluck(:code)
    tenants.flatten.each do |tenant|
      puts "Criando funções para #{tenant}"
      Apartment::Tenant.switch!(tenant)

      query = 'CREATE OR REPLACE FUNCTION sem_acento(text) RETURNS text AS $$ '
      query += 'SELECT '
      query += "translate($1,'ÀÁÂÃÄÅĀĂĄÈÉÊËĒĔĖĘĚÌÍÎÏĨĪĮİÒÓÔÕÖØŌŎŐÙÚÛÜŨŪŬŮŰŲàáâãäåāăąèéêëēĕėęěìíîïĩīĭįòóôõöøōŏőùúûüũūŭůųÇçÑñÝýÿĆćĈĉĊċČčĎďĐđĜĝĞğĠġĢģĤĥĦħ','AAAAAAAAAEEEEEEEEEIIIIIIIIOOOOOOOOOUUUUUUUUUUaaaaaaaaaeeeeeeeeeiiiiiiiiooooooooouuuuuuuuuCcNnYyyCcCcCcCcDdDdGgGgGgGgHhHh'); "
      query += '$$ '
      query += 'LANGUAGE SQL IMMUTABLE STRICT;'
      ActiveRecord::Base.connection.execute(query)
    end
  end
end
