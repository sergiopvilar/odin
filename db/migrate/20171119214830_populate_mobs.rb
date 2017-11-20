class PopulateMobs < ActiveRecord::Migration[5.1]
  def change
    file = File.open("#{Rails.root}/db/json/mob.json", "rb")
    contents = file.read
    objects = ActiveSupport::JSON.decode(contents)

    objects["mob"].each do |i|
      Mob.create(
        uid: i["ID"],
        sprite: i["Sprite_Name"],
        name_portuguese: i["kROName"],
        level: i["LV"],
        hp: i["HP"],
        sp: i["SP"],
        exp: i["EXP"],
        job_exp: i["JEXP"],
        range: i["Range1"],
        atk1: i["ATK1"],
        atk2: i["ATK2"],
        def: i["DEF"],
        mdef: i["MDEF"],
        str: i["STR"],
        int: i["INT"],
        agi: i["AGI"],
        vit: i["VIT"],
        dex: i["DEX"],
        luk: i["LUK"],
        range2: i["Range2"],
        range3: i["Range3"],
        scale: i["Scale"],
        race: i["Race"],
        element: i["Element"],
        speed: i["Speed"],
        adelay: i["aDelay"],
        admotion: i["aMotion"],
        dmotion: i["dMotion"]
      )
    end
  end
end
