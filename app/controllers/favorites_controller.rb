class FavoritesController < ApplicationController
  def create
    @onsen = Onsen.find(params[:onsen_id])
    @favorite = current_user.favorites.new(onsen_id: @onsen.id)
    @favorite.save
    flash[:notice] = "行きたい温泉リストが追加されました。"
    redirect_to request.referer
  end

  def destroy
    @onsen = Onsen.find(params[:onsen_id])
    @favorite = current_user.favorites.find_by(onsen_id: @onsen.id)
    @favorite.destroy
    flash[:notice] = "行きたい温泉リストが削除されました。"
    redirect_to request.referer
  end
end
