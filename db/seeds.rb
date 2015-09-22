require "twitter"
require "csv"

CANDIDATES = {
	bush: { first_name: "Jeb", last_name: "Bush", twitter_handle: "@JebBush", party: "Republican", bio: "John Ellis 'Jeb' Bush (born February 11, 1953) is an American businessman and politician who served as the 43rd Governor of Florida from 1999 to 2007." },
	carson: { first_name: "Ben", last_name: "Carson", twitter_handle: "@RealBenCarson", party: "Republican", bio: "Benjamin Solomon 'Ben' Carson, Sr. (born September 18, 1951) is an American author, politician, and retired Johns Hopkins neurosurgeon." },
	chafee: { first_name: "Lincoln", last_name: "Chafee", twitter_handle: "@LincolnChafee", party: "Democrat", bio: "Lincoln Davenport Chafee (born March 26, 1953) is an American politician from Rhode Island who has served as the Mayor of Warwick (1993–1999), a U.S. Senator (1999–2007) and as the 74th Governor of Rhode Island (2011–2015)." },
	christie: { first_name: "Chris", last_name: "Christie", twitter_handle: "@GovChristie", party: "Republican", bio: "Christopher James 'Chris' Christie (born September 6, 1962) is the 55th Governor of New Jersey. He has been governor since January 2010 and was re-elected for a second term in the 2013 election." },
	clinton: { first_name: "Hillary", last_name: "Clinton", twitter_handle: "@HillaryClinton", party: "Democrat", bio: "Hillary Diane Rodham Clinton (born October 26, 1947) is an American politician who served as the 67th United States Secretary of State under President Barack Obama from 2009 to 2013. " },
	cruz: { first_name: "Ted", last_name: "Cruz", twitter_handle: "@SenTedCruz", party: "Republican", bio: "Rafael Edward 'Ted' Cruz (born December 22, 1970) is the junior U.S. Senator from Texas." },
	fiorina: { first_name: "Carly", last_name: "Fiorina", twitter_handle: "@CarlyFiorina", party: "Republican", bio: "Carly Fiorina (born Cara Carleton Sneed, September 6, 1954) is an American Republican politician and former business executive who currently chairs the non-profit philanthropic organization Good360." },
	gilmore: { first_name: "Jim", last_name: "Gilmore", twitter_handle: "@gov_gilmore", party: "Republican", bio: "James Stuart 'Jim' Gilmore III (born October 6, 1949) is an American politician who was the 68th Governor of Virginia from 1998 to 2002." },
	graham: { first_name: "Lindsey", last_name: "Graham", twitter_handle: "@LindseyGrahamSC", party: "Republican", bio: "Lindsey Olin Graham (born July 9, 1955) is an American politician and member of the Republican Party, who has served as a United States Senator from South Carolina since 2003, and has been the senior Senator from South Carolina since 2005." },
	huckabee: { first_name: "Mike", last_name: "Huckabee", twitter_handle: "@GovMikeHuckabee", party: "Republican", bio: "Michael Dale 'Mike' Huckabee (born August 24, 1955) is an American politician, Christian minister, author, and commentator who served as the 44th Governor of Arkansas from 1996 to 2007." },
	jindal: { first_name: "Bobby", last_name: "Jindal", twitter_handle: "@BobbyJindal", party: "Republican", bio: "Piyush 'Bobby' Jindal (born June 10, 1971) is an American politician who is the 55th governor of Louisiana, a former US Congressman, and former vice chairman of the Republican Governors Association." },
	kasich: { first_name: "John", last_name: "Kasich", twitter_handle: "@JohnKasich", party: "Republican", bio: "John Richard Kasich (born May 13, 1952) is an American politician and the 69th and current Governor of Ohio, elected to the office in 2010 and reelected in the 2014 election. On July 21, 2015, he announced his candidacy for the Republican nomination for president in 2016." },
	omalley: { first_name: "Martin", last_name: "O'Malley", twitter_handle: "@MartinOMalley", party: "Democrat", bio: "Martin Joseph O'Malley (born January 18, 1963) was the 61st Governor of Maryland, from 2007 to 2015, and is running for President of the United States in the 2016 election." },
	pataki: { first_name: "George", last_name: "Pataki", twitter_handle: "@GovernorPataki", party: "Republican", bio: "George Elmer Pataki (born June 24, 1945) is an American lawyer and politician who served as the 53rd Governor of New York (1995–2006)." },
	paul: { first_name: "Rand", last_name: "Paul", twitter_handle: "@RandPaul", party: "Republican", bio: "Randal Howard 'Rand' Paul (born January 7, 1963) is an American politician and physician." },
	rubio: { first_name: "Marco", last_name: "Rubio", twitter_handle: "@marcorubio", party: "Republican", bio: "Marco Antonio Rubio (born May 28, 1971) is the junior United States Senator from Florida, serving since January 2011, and a candidate for President of the United States." },
	sanders: { first_name: "Bernie", last_name: "Sanders", twitter_handle: "@SenSanders", party: "Democrat", bio: "Bernard 'Bernie' Sanders (born September 8, 1941) is an American politician and the junior United States Senator from Vermont." },
	santorum: { first_name: "Rick", last_name: "Santorum", twitter_handle: "@RickSantorum", party: "Republican", bio: "Richard John 'Rick' Santorum (born May 10, 1958) is an American attorney and Republican Party politician." },
	trump: { first_name: "Donald", last_name: "Trump", twitter_handle: "@realDonaldTrump", party: "Republican", bio: "Donald John Trump (born June 14, 1946) is an American real estate developer, television personality, business author and political candidate." },
	# walker: { first_name: "Scott", last_name: "Walker", twitter_handle: "@ScottWalker", party: "Republican", bio: "Scott Kevin Walker (born November 2, 1967) is the 45th Governor of Wisconsin, serving since 2011, and a candidate for the Republican Party's nomination to the 2016 presidential election." },
	webb: { first_name: "Jim", last_name: "Webb", twitter_handle: "@JimWebbUSA", party: "Democrat", bio: "James Henry 'Jim' Webb, Jr. (born February 9, 1946) is an American politician and author." }
}

CATEGORIES = [
	{
		name: "Unemployment",
		keywords: ["unemployment", "reform", "welfare", "homelessness", "poverty", "hunger", "labor", "union"]
	},
	{
		name: "Taxes",
		keywords: ["tax", "refund", "wealth", "inheritance", "cuts", "interest", "irs", "reform"]
	},
	{
		name: "Health Care",
		keywords: ["health", "care", "healthcare", "obamacare", "medicare", "medicaid", "insurance", "abortion"]
	},
	{
		name: "Corporate Corruption",
		keywords: ["corporate", "corruption", "lobbying", "inequality", "wages"]
	},
	{
		name: "Terrorism",
		keywords: ["terrorism", "isis", "bengazi", "iran", "cyberterrorism", "islam"]
	},
	{
		name: "Foreign Policy",
		keywords: ["foreign", "china", "cuba", "trade", "afghanistan"]
	},
	{
		name: "Immigration",
		keywords: ["immigration", "reform", "undocumented", "illegal"]
	},
	{
		name: "Climate Change",
		keywords: ["climate", "energy", "keystone", "green"]
	},
	{
		name: "Education",
		keywords: ["education", "testing", "stem", "technology", "reform", "vouchers"]
	},
	{
		name: "Race Relations",
		keywords: ["race", "ferguson", "racism", "incarceration", "diversity", "black", "hispanic"]
	},
	{
		name: "Marriage Equality",
		keywords: ["marriage", "equality", "homosexual", "gay", "transgender", "lesbian", "legalization", "tradition"]
	}
]

# candidates = []
# CANDIDATES.each do |candidate, info|
# 	candidates << Candidate.create!(info)
# end
#
# categories = []
# CATEGORIES.each do |category|
# 	new_category = Category.create!(name: category[:name])
# 	category[:keywords].each do |keyword|
# 		new_category.keywords.create!(word: keyword)
# 	end
# 	categories << new_category
# end

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

# def parse_transcript(file_path)
# 	transcript = File.read(file_path)
#
# 	quotes = transcript.split(/(^[A-Z]+:)/)
# 	quotes.delete_at(0)
#
# 	names = quotes.select.with_index { |quote, index| index.even? }
# 	lines = quotes.select.with_index { |quote, index| index.odd? }
# 	names.map! { |name| name.downcase.delete(":").to_sym }
#
# 	quotes = names.zip(lines)
#
# 	quotes.each.with_index do |quote, index|
# 		quotes[(index + 1)..-1].each do |quote_to_compare|
# 			if quote[0] == quote_to_compare[0]
# 				quote[1] << quote_to_compare[1]
# 				quotes.delete(quote_to_compare)
# 			end
# 		end
# 	end
#
# 	quotes = Hash[quotes]
# 	quotes.delete_if { |candidate, lines| CANDIDATES.has_key?(candidate) == false }
# end
#
# def compile_text(directory_path)
# 	Dir.foreach(directory_path) do |filename|
# 		next if filename == '.' or filename == '..'
# 		text = File.read("#{directory_path}/#{filename}")
# 		candidate = filename.slice(/\A[a-z]+/)
# 		write_to_master(candidate, text)
# 	end
# end
#
# def write_to_master(candidate, text, options = {})
# 	mode = options.fetch(:mode, "a")
# 	File.open("db/raw-text/master-files/#{candidate}_master.txt", mode) do |file|
# 		file << text
# 	end
# end
#
# cnn_republican_debate = parse_transcript("db/raw-text/debates/cnn_republican_debate.txt")
# fox_republican_debate = parse_transcript("db/raw-text/debates/fox_republican_debate.txt")
# debates = cnn_republican_debate.merge(fox_republican_debate) { |key, cnn_lines, fox_lines| cnn_lines + fox_lines }
#
# debates.each do |candidate, text|
# 	write_to_master(candidate, text)
# end
#
# compile_text("db/raw-text/speeches")
# compile_text("db/raw-text/tweets")

def write_categories_data_to_json
	categories_data = {}
	Candidate.all.each do |candidate|
		last_name = candidate.last_name.downcase
		categories_data[last_name] = { }
		categories_data[last_name]["children"] = candidate.categories_data
	end
	File.open("public/categories_data.json", "w") do |file|
		file << categories_data.to_json
	end
end

write_categories_data_to_json
