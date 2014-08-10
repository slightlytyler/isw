module PostsHelper
  def first_monday week, year
    Chronic.parse('year ' + year.to_s)
  end
end