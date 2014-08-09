# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  guide        :string(255)
#  name         :string(255)
#  url          :string(255)
#  published_at :datetime
#  image        :string(255)
#  content      :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Post < ActiveRecord::Base
  attr_accessible :guide, :name, :url, :published_at, :image, :content

  def self.update_from_feed
    feed = Feedjira::Feed.fetch_and_parse("http://iswiraq.blogspot.com/feeds/posts/default?start-index=1&max-results=28")
    feed.entries.each do |entry|
      record = Post.find_or_initialize_by(guide: entry.id)
      record.name          = entry.title
      record.url           = entry.url
      record.published_at  = entry.published
      record.guide         = entry.id
      record.image         = nil
      record.content       = entry.content
      record.save
    end
  end
end
