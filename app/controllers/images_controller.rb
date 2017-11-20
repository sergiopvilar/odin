require 'open-uri'

class ImagesController < ApplicationController

  def mob
    mob = Mob.find_by_uid(params[:id])
    get_image('mob', 'gif', mob.uid)
  end

  def item
    item = Item.find_by_uid(params[:id])
    get_image('item', 'png', item.uid)
  end

  def item_big
    item = Item.find_by_uid(params[:id])
    get_image('collection', 'png', item.uid)
  end

  private

  def get_image(prefix, extesion, id)
    filename = "#{Rails.public_path}/icons/#{prefix}/#{id}.#{extesion}"
    url = "https://www.ragnaplace.com/db/#{prefix}/#{id}.#{extesion}"
    begin
      unless File.exist?(filename)
        open(filename, 'wb') do |file|
          file << open(url).read
        end
      end
      send_file Rails.root.join("public", "icons", prefix, "#{id}.#{extesion}"), type: "image/#{extesion}", disposition: "inline"
    rescue
      File.delete(filename) if File.exist?(filename)
      send_file Rails.root.join("public", "icons", prefix, "default.#{extesion}"), type: "image/#{extesion}", disposition: "inline"
    end
  end

end
