class MapsController < ApplicationController
  def show
    @map = Map.find_by_name(params[:id])
  end
end
