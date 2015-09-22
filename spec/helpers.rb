module Helpers
  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: "twitter",
      uid: "325235235",
      extra: {
        raw_info: {
          user_id: "1234",
          name: "Sebastian Abondano", 
          screen_name: "sabondano1",
        }
      },
      credentials: {
        token: ENV["twitter_access_token"],
        secret: ENV["twitter_access_token_secret"]
      }
    })

  end
end

