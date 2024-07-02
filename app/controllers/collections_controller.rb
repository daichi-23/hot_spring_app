class CollectionsController < ApplicationController
  def create
    @onsen = Onsen.find(params[:onsen_id])
    @collection = current_user.collections.new(onsen_id: @onsen.id)
    @collection.save
    flash[:notice] = "行った温泉リストが追加されました。"
    redirect_to request.referer
  end

  def edit
    @onsen = Onsen.find(params[:onsen_id])
    @collection = current_user.collections.find_by(onsen_id: @onsen.id)
  end

  def update
    @onsen = Onsen.find(params[:onsen_id])
    @collection = current_user.collections.find_by(onsen_id: @onsen.id)
    if @collection.update(collection_params)
      flash[:notice] = "コメントが更新されました。"
      redirect_to onsen_path(@onsen)
    else
      session[:error_messages] = @collection.errors.full_messages   
      redirect_to edit_onsen_collection_path(@onsen)
    end
  end

  def destroy
    @onsen = Onsen.find(params[:onsen_id])
    @collection = current_user.collections.find_by(onsen_id: @onsen.id)
    @collection.destroy
    flash[:notice] = "行った温泉リストが削除されました。"
    redirect_to request.referer
  end

  private
  
  def collection_params
    params.require(:collection).permit(:comment, :user_id, :onsen_id)
  end
end
