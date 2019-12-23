class UsersController < ApplicationController

  def index
  end
  
  def show
    user = User.find(params[:id])
    @name = user.name
    @posts = user.posts
  end

  def mypage
    @posts = current_user.posts
  end

end
