class MapsController < ApplicationController
  def show
    @map = Map.find_by_name(params[:id])
  end

  def search
    @title = 'Busca de mapas'
    @maps = Map.results_for(params[:s]).limit(20)
    redirect_to map_path(@maps.first.name) if @maps.size == 1
  end
end
