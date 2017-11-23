class MapsController < ApplicationController
  def show
    @map = Map.find_by_id(params[:id])
  end
end
