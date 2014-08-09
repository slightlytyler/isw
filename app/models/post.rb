class Post < ActiveRecord::Base
  attr_accessible :guide, :name, :url, :published_at, :image
end
