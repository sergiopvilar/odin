class MobsController < ApplicationController

  def show
    @mob = Mob.includes(:respawns, :drops).find_by_uid(params[:id])
    @title = @mob.name
    @image = @mob.image
    @description = @mob.description
  end

end
