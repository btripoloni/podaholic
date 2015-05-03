class SubmitWorker
  include Sidekiq::Worker

  def perform(podcast_id)
    # do some work
  end
end

