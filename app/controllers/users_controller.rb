class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @onsen = @user.onsens.order("updated_at DESC")
    my_favorites = Favorite.where(user_id: @user.id).pluck(:onsen_id)
    @favorites = Onsen.find(my_favorites)
    my_collections = Collection.where(user_id: @user.id).pluck(:onsen_id)
    @collections = Onsen.find(my_collections)
    @collection = Collection.find_by(onsen_id: @onsen.ids)
  end

  def collection
    @user = User.find(params[:id])
    my_collections = Collection.where(user_id: @user.id).pluck(:onsen_id)
    @onsens = Onsen.find(my_collections)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "プロフィール情報が変更されました。"
      redirect_to user_path(@user)
    else
      flash[:alert] = "プロフィール情報の変更に失敗しました。"
      session[:error_messages] = @user.errors.full_messages
      redirect_to edit_user_path(@user)
    end
  end

  def dummy
    redirect_back(fallback_location: root_path)
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :image, :introduction, :image_cache, :remove_image)
  end
end
