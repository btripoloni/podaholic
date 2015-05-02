class Podcast < ActiveRecord::Base
  has_many :episodes
  validates_presence_of :name, :feed_url
end
