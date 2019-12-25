class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end

  def create
    Profile.create(profile_params)
    redirect_to user_path(id: current_user.id), notice: 'プロフィールを保存しました'
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update(profile_params)
    redirect_to user_path(current_user.id)
  end

  private
  def profile_params
    params.require(:profile).permit(:content, :region, :website).merge(user_id: current_user.id)
  end

end
