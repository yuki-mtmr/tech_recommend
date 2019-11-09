class PostsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
  end

  private
  def post_params
    params.require(:post).permit(:name, :url)
  end
end
