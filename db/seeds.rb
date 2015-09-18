# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "twitter"

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

raw_text = {}

TWITTER_HANDLES.each do |candidate, handle|
	raw_text[candidate] = client.user_timeline(handle, count: 200, include_rts: false).map { |tweet| tweet.text }
end

raw_text.each { |candidate, tweets| p tweets.count }
