class ItemsController < ApplicationController
  respond_to :json

  def show
    @item = Item.includes(:drops).find_by_uid(params[:id])
    @title = @item.name
    @image = @item.big_image
    @description = Sanitize.clean(@item.full_description).strip
  end
end

