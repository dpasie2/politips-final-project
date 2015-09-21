require "csv"
require "twitter"

# CSV.open("db/raw_text/tweets/test.csv", "w") do |csv|
# 	["hey what's up", "how's it going", "I never know what to write in these tests"].each_slice(1).to_a.each do |row|
# 		csv << row
# 	end
# end
#
# [tweet, tweet, tweet].each do |tweet|
# 	csv << [tweet.created_at, tweet.text]
# end

tweets = {}

client = Twitter::REST::Client.new do |config|
	config.consumer_key			= Rails.application.secrets.twitter_consumer_key
	config.consumer_secret	= Rails.application.secrets.twitter_consumer_secret
end

tweets[:sanders] = client.user_timeline("@SenSanders")

tweets.each do |candidate, candidate_tweets|
	CSV.open("db/raw_text/tweets/#{candidate}_tweets.csv", "w") do |csv|
		csv << ["created_at", "text"]
		candidate_tweets.each do |tweet|
			csv << [tweet.created_at, tweet.text]
		end
	end
end
