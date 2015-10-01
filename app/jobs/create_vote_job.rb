class CreateVoteJob < ActiveJob::Base
  queue_as :default

  def perform(episode_id, user_id)
    Vote.create(episode_id: episode_id, user_id: user_id)
  end
end
