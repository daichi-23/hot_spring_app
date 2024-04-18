class UsersController < ApplicationController
  def show
    @user = current_user
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
      redirect_to user_edit_path(@user)
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
