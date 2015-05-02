class Episode < ActiveRecord::Base
  searchkick highlight: [:show_notes]
  belongs_to :podcast

  validates_presence_of :title, :media_url, :podcast_id

  delegate :name, to: :podcast, prefix: true

  def search_data
    attributes.merge(
      podcast_name: podcast_name
    )

  end
end
