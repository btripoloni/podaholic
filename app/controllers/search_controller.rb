class SearchController < ApplicationController
  def index
    @episodes = Episode.search params[:q].presence || '*', page: params[:page], per_page: 10, includes: :podcast
  end
end
