class AutocompleteController < ApplicationController
  respond_to :json

  def items
    fetch(Item, 10)
  end

  def maps
    fetch(Map, 20)
  end

  def mobs
    fetch(Mob)
  end

  private

  def fetch(model, limit = 5)
    term = Sanitize.clean(params[:s])
    if term.length < 3
      respond_with []
      return
    end
    objects = model.results_for(term).limit(5)
    render json: objects.to_json
  end

end
