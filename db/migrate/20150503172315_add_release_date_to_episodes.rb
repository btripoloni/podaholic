class AddReleaseDateToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :release_date, :datetime
  end
end
