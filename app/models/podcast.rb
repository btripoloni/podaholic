class Podcast < ActiveRecord::Base
  has_many :episodes
  validates_presence_of :name, :feed_url

  def self.import_by_feed_url(feed_url)
    feed = Feed.new(feed_url)
    feed.fetch!

    podcast = find_or_create_by(feed_url: feed_url).tap do |pod|
      pod.name        = feed.podcast.name
      pod.description = feed.podcast.description  if feed.podcast.description.present?
      pod.image_url   ||= feed.podcast.image_url  if feed.podcast.image_url.present?
      pod.save
    end

    feed.episodes.each do |episode|
      podcast.episodes.create(title: episode.title,
                              permalink: episode.link,
                              duration: episode.duration,
                              show_notes: episode.summary,
                              art_work_url: episode.image_url || feed.podcast.image_url,
                              media_url:  episode.audio_url)
    end
  end

  def self.import_by_apple_podcast_id(podcast_id)
    apple_podcast_info = ITunesSearchAPI.lookup(id: podcast_id)
    raise 'podcast not found' if apple_podcast_info['trackId'].nil?

    podcast = find_or_create_by(feed_url: apple_podcast_info['feedUrl']).tap do |pod|
      pod.name        = apple_podcast_info['trackName']
      pod.image_url   = apple_podcast_info['artworkUrl100']
      pod.save
    end

    import_by_feed_url(podcast.feed_url)
  end
end
