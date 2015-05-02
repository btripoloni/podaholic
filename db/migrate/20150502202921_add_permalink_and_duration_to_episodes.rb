class AddPermalinkAndDurationToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :permalink, :string
    add_column :episodes, :duration, :string
  end
end
