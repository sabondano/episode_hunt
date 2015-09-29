class User < ActiveRecord::Base
  has_many :episodes
  has_many :votes

  def self.find_or_create_from_oauth(auth_info)
    user = User.find_or_create_by(provider: auth_info.provider, uid: auth_info.uid)

    user.name               = auth_info.extra.raw_info.name
    user.provider           = auth_info.provider
    user.screen_name        = auth_info.extra.raw_info.screen_name
    user.uid                = auth_info.uid
    user.profile_image_url  = auth_info.extra.raw_info.profile_image_url
    user.oauth_token        = auth_info.credentials.token
    user.oauth_token_secret = auth_info.credentials.secret
    user.save

    user
  end

  def upvoted_episodes
    votes.map { |vote| vote.episode }
  end
end
