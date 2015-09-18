Twitter.configure do |config|
  config.consumer_key = Rails.application.secrets.twitter_consumer_key
  config.consumer_secret	= Rails.application.secrets.twitter_consumer_secre
end
