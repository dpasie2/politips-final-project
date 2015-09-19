# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "twitter"
require "csv"

TWITTER_HANDLES = {
	sanders: "@SenSanders",
	clinton: "@HillaryClinton",
	chafee: "@LincolnChafee",
	omalley: "@MartinOMalley",
	webb: "@JimWebbUSA",
	bush: "@JebBush",
	carson: "@RealBenCarson",
	christie: "@GovChristie",
	cruz: "@SenTedCruz",
	fiorina: "@CarlyFiorina",
	gilmore: "@gov_gilmore",
	graham: "@LindseyGrahamSC",
	huckabee: "@GovMikeHuckabee",
	jindal: "@BobbyJindal",
	kasich: "@JohnKasich",
	pataki: "@GovernorPataki",
	paul: "@RandPaul",
	rubio: "@marcorubio",
	santorum: "@RickSantorum",
	trump: "@realDonaldTrump",
	walker: "@ScottWalker"
}

client = Twitter::REST::Client.new do |config|
	config.consumer_key			= Rails.application.secrets.twitter_consumer_key
	config.consumer_secret	= Rails.application.secrets.twitter_consumer_secret
end

tweets = {}

def client.get_all_tweets(user)
  collect_with_max_id do |max_id|
    options = {count: 200, include_rts: false}
    options[:max_id] = max_id unless max_id.nil?
		user_timeline(user, options)
  end
end

TWITTER_HANDLES.each do |candidate, handle|
	begin
		tweets[candidate] = client.get_all_tweets(handle)
	rescue Twitter::Error::TooManyRequests => error
		sleep error.rate_limit.reset_in + 1
		redo
	end
end

tweets.each do |candidate, candidate_tweets|
	CSV.open("db/raw_text/tweets/#{candidate}_tweets.csv", "w") do |csv|
		csv << ["created_at", "text"]
		candidate_tweets.each do |tweet|
			csv << [tweet.created_at, tweet.text]
		end
	end
end
