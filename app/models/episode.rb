class Episode < ActiveRecord::Base
  searchkick
  belongs_to :podcast

  validates_presence_of :title, :media_url, :podcast_id

  delegate :name, to: :podcast, prefix: true
end
