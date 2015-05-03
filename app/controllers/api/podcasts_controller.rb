module API
  class PodcastsController < ApplicationController
    def submit
      if podcast_id = params[:podcast_id]
        SubmitWorker.perform_async(podcast_id)
        head :accepted
      else
        head :bad_request
      end
    end
  end
end
