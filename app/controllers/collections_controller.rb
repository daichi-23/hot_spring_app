class CollectionsController < ApplicationController
  def create
    @onsen = Onsen.find(params[:onsen_id])
    @collection = current_user.collections.new(onsen_id: @onsen.id)
    @collection.save
    flash[:notice] = "行った温泉リストが追加されました。"
    redirect_to request.referer
  end

  def destroy
    @onsen = Onsen.find(params[:onsen_id])
    @collection = current_user.collections.find_by(onsen_id: @onsen.id)
    @collection.destroy
    flash[:notice] = "行った温泉リストが削除されました。"
    redirect_to request.referer
  end
end
