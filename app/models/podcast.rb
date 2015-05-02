class Podcast < ActiveRecord::Base
  has_many :episodes
  validates_presence_of :name, :feed_url

  def self.import_by_feed_url(feed_url)
    feed = Feed.new(feed_url)
    feed.fetch!

    podcast = find_or_create_by(feed_url: feed_url) do |pod|
      pod.name        = feed.podcast.name
      pod.description = feed.podcast.description
    end

    feed.episodes.each do |episode|
      podcast.episodes.create(title: episode.title,
                              show_notes: episode.summary,
                              media_url:  episode.audio_url)
    end
  end
end
