class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.text :show_notes
      t.string :media_url
      t.string :art_work_url
      t.references :podcast, index: true

      t.timestamps null: false
    end
    add_foreign_key :episodes, :podcasts
  end
end
