# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  guide        :string(255)
#  name         :string(255)
#  url          :string(255)
#  published_at :datetime
#  week         :integer
#  month        :integer
#  year         :integer
#  image        :text
#  content      :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Post < ActiveRecord::Base
  attr_accessible :guide, :name, :url, :published_at, :week, :month, :year, :image, :content

  def self.update_from_feed
    feed = Feedjira::Feed.fetch_and_parse("http://iswiraq.blogspot.com/feeds/posts/default?start-index=1&max-results=5000")
    feed.entries.each do |entry|
      if entry.title.include? 'Situation Report'
        record = Post.find_or_initialize_by(guide: entry.id)
        record.name          = entry.title
        record.url           = entry.url
        record.published_at  = entry.published
        record.week          = entry.published.strftime('%W')
        record.month          = entry.published.strftime('%M')
        record.year          = entry.published.strftime('%Y')
        record.guide         = entry.id
        record.image         = Nokogiri::HTML(entry.content).css('img').map{ |i| i['src'] }[0]
        record.content       = entry.content
        record.save
      end
    end
  end
end