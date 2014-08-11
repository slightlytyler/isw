module PostsHelper
  def get_weeks_posts week, year
    return @posts = Post.order("published_at DESC").where(week: week, year: year)
  end

  def get_home_image
    return Post.home_background
  end
end