class SearchController < ApplicationController
  def index
    @episodes = Episode.search params[:q].presence || '*', page: params[:page], per_page: 10, includes: :podcast, facets: [:podcast_name], highlight: { tag: "<strong>", fields: { show_notes: { fragment_size: 300 } } }, fields: [:show_notes], fields: ['title^10', 'show_notes']
  end
end
