class AutocompleteController < ApplicationController
  respond_to :json

  def items
    term = Sanitize.clean(params[:s])
    if term.length < 3
      respond_with []
      return
    end
    items = Item.where("lower(name_portuguese) LIKE ?", "%#{term.downcase}%")
                .or(Item.where(uid: term))
                .limit(5)
    render json: items.to_json
  end

  def mobs
    term = Sanitize.clean(params[:s])
    if term.length < 3
      respond_with []
      return
    end
    mobs = Mob.where("lower(name_portuguese) LIKE ?", "%#{term.downcase}%")
              .or(Mob.where(uid: term))
              .limit(5)
    render json: mobs.to_json
  end
end
