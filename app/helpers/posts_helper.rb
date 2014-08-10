module PostsHelper
  def get_weeks_posts week, year
    return @posts = Post.order("published_at DESC").where(week: week, year: year)
  end
end