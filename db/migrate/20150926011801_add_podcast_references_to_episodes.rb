class AddPodcastReferencesToEpisodes < ActiveRecord::Migration
  def change
    add_reference :episodes, :podcast, index: true, foreign_key: true
  end
end
