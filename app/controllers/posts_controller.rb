class PostsController < ApplicationController
  def week_index
    @increment = 'week';
    @posts = Post.order("published_at DESC")
    get_range
    @increment_end = @posts.first.week
    @increment_start = @posts.last.week
    
    render "posts/index"
  end

  def month_index
    @increment = 'month';
    @posts = Post.order("published_at DESC")
    get_range
    @increment_end = @posts.first.month
    @increment_start = @posts.last.month

    render "posts/index"
  end

  def year_index
    @increment = 'year';
    @posts = Post.order("published_at DESC")
    get_range
    @increment_end = @current_year
    @increment_start = @first_year

    render "posts/index"
  end

  def week
    @week = params[:week]
    @year = params[:year]
    @posts = Post.order("published_at DESC").where(week: @week, year: @year)
    get_range
    render "posts/show"
  end

  def month
    @month = params[:month]
    @year = params[:year]
    @posts = Post.order("published_at DESC").where(month: @month, year: @year)
    get_range
    render "posts/show"
  end

  def year
    @year = params[:year]
    @posts = Post.order("published_at DESC").where( year: @year)
    get_range
    render "posts/show"
  end

  def update_all
    Post.update_from_feed
    flash[:notice] = "Feed Updated"
    redirect_to root_path
  end

  private
  def get_range
    @current_year = @posts.first.year
    @first_year = @posts.last.year
  end
end
