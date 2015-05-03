class SubmitWorker
  include Sidekiq::Worker

  def perform(podcast_id)
    Podcast.import_by_apple_podcast_id(podcast_id)
  end
end

