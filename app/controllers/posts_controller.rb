class PostsController < ApplicationController

  before_action :today, only: :index


  def index
    @posts = Post.includes(:user).order("created_at DESC")
    @like = Like.new
    @recommends = session[:today]
  end


  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      redirect_to root_path, notice: '投稿を追加しました。'
    else
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  def today
    if session[:today].blank?
      session[:today] = Post.order("RAND()").limit(3)
      redirect_to root_path
    end
  end

  def destroy_today
    session[:today] = ''
    puts "成功しました"
  end


  private

  def post_params
    params.require(:post).permit(:url, category_ids: []).merge(user_id: current_user.id)

  end

end
