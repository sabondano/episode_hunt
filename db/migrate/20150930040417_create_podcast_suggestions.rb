class CreatePodcastSuggestions < ActiveRecord::Migration
  def change
    create_table :podcast_suggestions do |t|
      t.string :suggestion
      t.string :status, default: "pending"

      t.timestamps null: false
    end
  end
end
