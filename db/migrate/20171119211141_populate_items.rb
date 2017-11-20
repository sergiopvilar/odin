class PopulateItems < ActiveRecord::Migration[5.1]
  def change
    file = File.open("#{Rails.root}/db/json/item.json", "rb")
    contents = file.read
    objects = ActiveSupport::JSON.decode(contents)

    objects["items"].each do |i|
      Item.create(
        uid: i["id"],
        name_aegis: i["nome_aegis"],
        name_portuguese: i["nome"],
        type: i["tipo"],
        price_buy: i["valor_compra"],
        price_sell: i["valor_venda"],
        weight: i["peso"],
        atk: i["atk"],
        defense: i["def"],
        range: i["alcance"],
        slots: i["slots"],
        upper: i["uper"],
        sex: i["sexo"],
        job: i["classe"],
        level_required: i["nivel_requerido"],
        weapon_level: i["nivel_arma"],
        refinable: i["refinavel"],
        view: i["view"],
        script: i["script"],
        script_equip: i["script_equip"],
        script_unequip: i["script_desequip"],
      )
    end
  end
end
