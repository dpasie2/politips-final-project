# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "twitter"
require "csv"

CANDIDATES = {
	sanders: { first_name: "Bernie", last_name: "Sanders", twitter_handle: "@SenSanders" },
	clinton: { first_name: "Hillary", last_name: "Clinton", twitter_handle: "@HillaryClinton" },
	chafee: { first_name: "Lincoln", last_name: "Chafee", twitter_handle: "@LincolnChafee" },
	omalley: { first_name: "Martin", last_name: "O'Malley", twitter_handle: "@MartinOMalley" },
	webb: { first_name: "Jim", last_name: "Webb", twitter_handle: "@JimWebbUSA" },
	bush: { first_name: "Jeb", last_name: "Bush", twitter_handle: "@JebBush" },
	carson: { first_name: "Ben", last_name: "Carson", twitter_handle: "@RealBenCarson" },
	christie: { first_name: "Chris", last_name: "Christie", twitter_handle: "@GovChristie" },
	cruz: { first_name: "Ted", last_name: "Cruz", twitter_handle: "@SenTedCruz" },
	fiorina: { first_name: "Carly", last_name: "Fiorina", twitter_handle: "@CarlyFiorina" },
	gilmore: { first_name: "Jim", last_name: "Gilmore", twitter_handle: "@gov_gilmore" },
	graham: { first_name: "Lindsey", last_name: "Graham", twitter_handle: "@LindseyGrahamSC" },
	huckabee: { first_name: "Mike", last_name: "Huckabee", twitter_handle: "@GovMikeHuckabee" },
	jindal: { first_name: "Bobby", last_name: "Jindal", twitter_handle: "@BobbyJindal" },
	kasich: { first_name: "John", last_name: "Kasich", twitter_handle: "@JohnKasich" },
	pataki: { first_name: "George", last_name: "Pataki", twitter_handle: "@GovernorPataki" },
	paul: { first_name: "Rand", last_name: "Paul", twitter_handle: "@RandPaul" },
	rubio: { first_name: "Marco", last_name: "Rubio", twitter_handle: "@marcorubio" },
	santorum: { first_name: "Rick", last_name: "Santorum", twitter_handle: "@RickSantorum" },
	trump: { first_name: "Donald", last_name: "Trump", twitter_handle: "@realDonaldTrump" },
	walker: { first_name: "Scott", last_name: "Walker", twitter_handle: "@ScottWalker" }
}

# client = Twitter::REST::Client.new do |config|
# 	config.consumer_key			= Rails.application.secrets.twitter_consumer_key
# 	config.consumer_secret	= Rails.application.secrets.twitter_consumer_secret
# end
#
# tweets = {}
#
# def client.get_all_tweets(user)
#   collect_with_max_id do |max_id|
#     options = {count: 200, include_rts: false}
#     options[:max_id] = max_id unless max_id.nil?
# 		user_timeline(user, options)
#   end
# end
#
# CANDIDATES.each do |candidate, candidate_info|
# 	begin
# 		tweets[candidate] = client.get_all_tweets(candidate_info[:twitter_handle])
# 	rescue Twitter::Error::TooManyRequests => error
# 		sleep error.rate_limit.reset_in + 1
# 		redo
# 	end
# end
#
# tweets.each do |candidate, candidate_tweets|
# 	File.open("db/raw-text/tweets/#{candidate}_tweets.txt", "w") do |file|
# 		candidate_tweets.each do |tweet|
# 			file << "#{tweet.text}\n"
# 		end
# 	end
# end

def parse_transcript(file_path)
	transcript = File.read(file_path)

	quotes = transcript.split(/(^[A-Z]+:)/)
	quotes.delete_at(0)

	names = quotes.select.with_index { |quote, index| index.even? }
	lines = quotes.select.with_index { |quote, index| index.odd? }
	names.map! { |name| name.downcase.delete(":").to_sym }

	quotes = names.zip(lines)

	quotes.each.with_index do |quote, index|
		quotes[(index + 1)..-1].each do |quote_to_compare|
			if quote[0] == quote_to_compare[0]
				quote[1] << quote_to_compare[1]
				quotes.delete(quote_to_compare)
			end
		end
	end

	quotes = Hash[quotes]
	quotes.delete_if { |candidate, lines| CANDIDATES.has_key?(candidate) == false }
end

def compile_text(directory_path)
	Dir.foreach(directory_path) do |filename|
		next if filename == '.' or filename == '..'
		text = File.read("#{directory_path}/#{filename}")
		candidate = filename.slice(/\A[a-z]+/)
		write_to_master(candidate, text)
	end
end

def write_to_master(candidate, text)
	File.open("db/raw-text/master-files/#{candidate}_master.txt", "a") do |file|
		file << text
	end
end

cnn_republican_debate = parse_transcript("db/raw-text/debates/cnn_republican_debate.txt")
fox_republican_debate = parse_transcript("db/raw-text/debates/fox_republican_debate.txt")
debates = cnn_republican_debate.merge(fox_republican_debate) { |key, cnn_lines, fox_lines| cnn_lines + fox_lines }

debates.each do |candidate, text|
	write_to_master(candidate, text)
end

compile_text("db/raw-text/speeches")
compile_text("db/raw-text/tweets")
