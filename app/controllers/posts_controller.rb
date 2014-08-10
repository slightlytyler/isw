class PostsController < ApplicationController
  def index
    @posts = Post.order("published_at DESC")
    get_range
  end

  def week
    @week = params[:week]
    @year = params[:year]
    @posts = Post.order("published_at DESC").where(week: @week, year: @year)
    get_range
  end

  def update_all
    Post.update_from_feed
    flash[:notice] = "Feed Updated"
    redirect_to root_path
  end

  def prev_monday

  end
  helper_method :prev_monday

  private
  def get_range
    @current_year = @posts.first.year
    @first_year = @posts.last.year
    @current_week = @posts.first.week
    @first_week = @posts.last.week
  end
end
