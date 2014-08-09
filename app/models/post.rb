class Post < ActiveRecord::Base
  feed = Feedzirra::Feed.fetch_and_parse("http://iswiraq.blogspot.com/feeds/posts/default?alt=rss")
  @entry = feed.entries
end
