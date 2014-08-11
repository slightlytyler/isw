# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  guide            :string(255)
#  name             :string(255)
#  url              :string(255)
#  published_at     :datetime
#  week             :integer
#  month            :integer
#  year             :integer
#  image            :text
#  background_image :text
#  content          :text
#  created_at       :datetime
#  updated_at       :datetime
#

class Post < ActiveRecord::Base
    attr_accessible :guide, :name, :url, :published_at, :week, :month, :year, :image, :background_image, :content

    FlickRaw.api_key="8e60dd79e0047a5c41f6f640cf5016e8"
    FlickRaw.shared_secret="8096d39dd9f30227"
    flickr_id = '50076792@N00'
    @@flickr_feed = flickr.photos.search(:user_id => flickr_id, :sort => 'interestingness-desc')

    def self.update_from_feed
        isw_url = 'http://iswiraq.blogspot.com/feeds/posts/default?start-index=1&max-results=5000'
        urls = [isw_url]
        feeds = Feedjira::Feed.fetch_and_parse urls
        isw_feed = feeds['http://iswiraq.blogspot.com/feeds/posts/default?start-index=1&max-results=5000']

        isw_feed.entries.each_with_index do |entry, i|
            if entry.title.include? 'Situation Report'
                photo_id = @@flickr_feed[i].id
                photo_info = flickr.photos.getInfo(:photo_id => photo_id)

                record = Post.find_or_initialize_by(guide: entry.id)
                record.name             = entry.title
                record.url              = entry.url
                record.published_at     = entry.published
                record.week             = entry.published.strftime('%W')
                record.month            = entry.published.strftime('%M')
                record.year             = entry.published.strftime('%Y')
                record.guide            = entry.id
                record.image            = Nokogiri::HTML(entry.content).css('img').map{ |i| i['src'] }[0]
                record.background_image = FlickRaw.url(photo_info)
                record.content          = entry.content
                record.save
            end
        end
    end

    def self.home_background

        home_photo_id = @@flickr_feed[0].id
        home_photo_info = flickr.photos.getInfo(:photo_id => home_photo_id)
        return FlickRaw.url(home_photo_info)
    end

end
