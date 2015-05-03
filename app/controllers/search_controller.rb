class SearchController < ApplicationController
  def index
    @episodes = Episode.search params[:q].presence || '*', options
  end

  protected

  def options
    {
      page: params[:page],
      per_page: 10,
      includes: :podcast,
      facets: [:podcast_name],
      highlight: {
        tag: '<strong>',
        show_notes: {
          fragment_size: 300
        }
      },
      fields: ['title^10', 'show_notes^5'],
      order: {
        _score: :desc,
        release_date: :desc
      },
      where: where_params
    }
  end

  def where_params
    params.permit(:podcast_name)
  end
end
