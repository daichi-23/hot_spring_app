class OnsensController < ApplicationController
  def index
    @onsens = Onsen.all
  end

  def new
    @onsen = Onsen.new
  end

  def create
    @onsen = Onsen.new(onsen_params)
    if @onsen.save
      flash[:notice] = "温泉地が投稿されました。"
      redirect_to onsens_path(@onsen)
    else
      session[:error_messages] = @onsen.errors.full_messages   
      redirect_to new_onsen_path
    end
  end

  def show
    @onsen = Onsen.find(params[:id])
    @user = User.find(@onsen.user_id)
  end

  def edit
    @onsen = Onsen.find(params[:id])
  end
  
  def update
    @onsen = Onsen.find(params[:id])
    if @onsen.update(onsen_params)
      flash[:notice] = "温泉地情報が更新されました。"
      redirect_to onsen_path(@onsen)
    else
      session[:error_messages] = @onsen.errors.full_messages   
      redirect_to edit_onsen_path(@onsen)
    end
  end

  def destroy
    @onsen = Onsen.find(params[:id])
    @onsen.destroy
    flash[:notice] = "温泉地が削除されました。"
    redirect_to onsens_path(@onsen)
  end

  private
  
  def onsen_params
    params.require(:onsen).permit(:onsen_name, :onsen_image, :onsen_introduction, :address, :user_id, :latitude, :longitude, :remove_onsen_image)
  end
end
