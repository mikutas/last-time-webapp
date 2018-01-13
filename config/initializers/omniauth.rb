Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
  Rails.application.secrets.google_oauth2[:key],
  Rails.application.secrets.google_oauth2[:secret] unless Rails.env.test?
end
