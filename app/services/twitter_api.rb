module TwitterAPI

	def self.client
		Twitter::REST::Client.new do |config|
    	config.consumer_key			= ENV["TWITTER_CONSUMER_KEY"]
    	config.consumer_secret	= ENV["TWITTER_CONSUMER_SECRET"]
    end
	end

	def self.get_all_tweets(user)
		client = self.client
		def client.get_all_tweets(user)
		  collect_with_max_id do |max_id|
		    options = {count: 200, include_rts: false}
		    options[:max_id] = max_id unless max_id.nil?
				user_timeline(user, options)
		  end
		end

		client.get_all_tweets(user)
	end

end
