class Podcast < ActiveRecord::Base
  validates_presence_of :name, :feed_url
end
