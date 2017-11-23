class MobsController < ApplicationController

  def show
    @mob = Mob.includes(:respawns, :drops).where(uid: params[:id]).where.not(respawns: { id: nil }).first
    raise ActiveRecord::RecordNotFound if @mob.blank?
    @title = @mob.name
    @image = @mob.image
    @description = @mob.description
  end

  def search
    @title = 'Busca de item'
    @mobs = Mob.results_for(params[:s]).limit(50)
    redirect_to mob_path(@mobs.first.uid) if @mobs.size == 1
  end
end
