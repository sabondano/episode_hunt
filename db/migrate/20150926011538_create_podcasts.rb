class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :name
      t.string :feed_url
      t.string :image
      t.string :link

      t.timestamps null: false
    end
  end
end
