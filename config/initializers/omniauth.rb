Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production? || Rails.env.development?
    provider :google_oauth2,
             Rails.application.credentials.google_oauth2[:key],
             Rails.application.credentials.google_oauth2[:secret]
  elsif Rails.env.test?
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: SecureRandom.uuid,
      info: {
        email: 'testuser@example.com'
      }
    )
  end
end
