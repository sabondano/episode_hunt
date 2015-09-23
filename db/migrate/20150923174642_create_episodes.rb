class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.string :link
      t.string :published_date
      t.string :duration
      t.string :audio_url
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
