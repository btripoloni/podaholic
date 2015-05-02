class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :name
      t.text :description
      t.text :feed_url

      t.timestamps null: false
    end
  end
end
