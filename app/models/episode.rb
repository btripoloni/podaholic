class Episode < ActiveRecord::Base
  searchkick highlight: [:show_notes]
  belongs_to :podcast

  validates_presence_of :title, :media_url, :podcast_id, :release_date
  validates_uniqueness_of :media_url

  delegate :name, to: :podcast, prefix: true

  scope :search_import, -> { includes(:podcast) }

  def search_data
    attributes.merge(podcast_name: podcast_name)
  end
end
