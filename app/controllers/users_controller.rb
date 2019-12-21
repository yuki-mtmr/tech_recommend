class UsersController < ApplicationController

  def index
  end
  
  def show
    user = User.find(params[:id])
    @name = user.name
    @posts = user.posts
  end

  def dashboard
  end

end
