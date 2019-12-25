class UsersController < ApplicationController

  def index
  end
  
  def show
    @user = User.find(params[:id])
    @profile = Profile.find_by(user_id: params[:id])
  end


end
