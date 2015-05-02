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
      puts episode.image_url
      podcast.episodes.create(title: episode.title,
                              permalink: episode.link,
                              duration: episode.duration,
                              show_notes: episode.summary,
                              art_work_url: episode.image_url || feed.podcast.image_url,
                              media_url:  episode.audio_url)
    end
  end
end
