class PostsController < ApplicationController
  require 'feedjira'
  require 'nokogiri'

  def index
    @posts = Post.order("published_at DESC")
  end

  def update_all
    Post.update_from_feed
    flash[:notice] = "Feed Updated"
    redirect_to root_path
  end
end
