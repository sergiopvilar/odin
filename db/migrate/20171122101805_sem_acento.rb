class SemAcento < ActiveRecord::Migration[5.1]
  def change
    query = 'CREATE OR REPLACE FUNCTION sem_acento(text) RETURNS text AS $$ '
    query += 'SELECT '
    query += "translate($1,'ÀÁÂÃÄÅĀĂĄÈÉÊËĒĔĖĘĚÌÍÎÏĨĪĮİÒÓÔÕÖØŌŎŐÙÚÛÜŨŪŬŮŰŲàáâãäåāăąèéêëēĕėęěìíîïĩīĭįòóôõöøōŏőùúûüũūŭůųÇçÑñÝýÿĆćĈĉĊċČčĎďĐđĜĝĞğĠġĢģĤĥĦħ','AAAAAAAAAEEEEEEEEEIIIIIIIIOOOOOOOOOUUUUUUUUUUaaaaaaaaaeeeeeeeeeiiiiiiiiooooooooouuuuuuuuuCcNnYyyCcCcCcCcDdDdGgGgGgGgHhHh'); "
    query += '$$ '
    query += 'LANGUAGE SQL IMMUTABLE STRICT;'
    ActiveRecord::Base.connection.execute(query)
  end
end
