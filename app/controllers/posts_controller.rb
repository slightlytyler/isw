class PostsController < ApplicationController
  require 'feedjira'
  require 'nokogiri'

  def index
    feed = Feedjira::Feed.fetch_and_parse("http://iswiraq.blogspot.com/feeds/posts/default?start-index=1&max-results=28")
    @feed_entries = feed.entries
  end
end
