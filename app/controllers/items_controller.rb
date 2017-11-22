class ItemsController < ApplicationController
  respond_to :json

  def show
    @item = Item.includes(:drops).find_by_uid(params[:id])
    @title = @item.name
    @image = @item.big_image
    @description = Sanitize.clean(@item.full_description).strip
  end

  def search
    @title = 'Busca de item'
    @items = Item.results_for(params[:s]).limit(50)
    redirect_to item_path(@items.first.uid) if @items.size == 1
  end
end

