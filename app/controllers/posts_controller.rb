class PostsController < ApplicationController
  def index
    get_posts
  end

  def week
    @week = params[:week]
    @year = params[:year]
    get_posts
    @weeks_posts = Post.order("published_at DESC").where(week: @week).select { |post| post.name.include? 'Situation' }
  end

  def update_all
    Post.update_from_feed
    flash[:notice] = "Feed Updated"
    redirect_to root_path
  end

  private
  def get_posts
    @posts = Post.order("published_at DESC").select { |post| post.name.include? 'Situation' }
    @current_year = @posts.first.year
    @first_year = @posts.last.year
    @current_week = @posts.first.week
    @first_week = @posts.last.week
  end
end
