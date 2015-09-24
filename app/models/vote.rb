class Vote < ActiveRecord::Base
  validates :user_id, :episode_id, presence: true
  validates :user_id, uniqueness: { scope: [:episode_id] }

  belongs_to :user
  belongs_to :episode
end
