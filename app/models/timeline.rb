require "twitter"

class Timeline

	def initialize(handle)
		@handle = handle
	end

	def client
		Twitter::REST::Client.new do |config|
			config.consumer_key			= Rails.application.secrets.twitter_consumer_key
			config.consumer_secret	= Rails.application.secrets.twitter_consumer_secret
		end
	end

	def tweets_content
		client.user_timeline(self.handle).map { |tweet| tweet.text }
	end

	protected

	attr_reader :handle

end
