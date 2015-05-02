class Episode < ActiveRecord::Base
  belongs_to :podcast

  validates_presence_of :title, :media_url, :podcast_id
end
