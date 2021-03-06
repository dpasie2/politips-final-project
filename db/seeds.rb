require "csv"

CANDIDATES = {
	trump: { first_name: "Donald", last_name: "Trump", twitter_handle: "realDonaldTrump", party: "Republican", bio: "Donald John Trump (born June 14, 1946) is an American real estate developer, television personality, business author and political candidate." },
	carson: { first_name: "Ben", last_name: "Carson", twitter_handle: "RealBenCarson", party: "Republican", bio: "Benjamin Solomon 'Ben' Carson, Sr. (born September 18, 1951) is an American author, politician, and retired Johns Hopkins neurosurgeon." },
	fiorina: { first_name: "Carly", last_name: "Fiorina", twitter_handle: "CarlyFiorina", party: "Republican", bio: "Carly Fiorina (born Cara Carleton Sneed, September 6, 1954) is an American Republican politician and former business executive who currently chairs the non-profit philanthropic organization Good360." },
	cruz: { first_name: "Ted", last_name: "Cruz", twitter_handle: "SenTedCruz", party: "Republican", bio: "Rafael Edward 'Ted' Cruz (born December 22, 1970) is the junior U.S. Senator from Texas." },
	rubio: { first_name: "Marco", last_name: "Rubio", twitter_handle: "marcorubio", party: "Republican", bio: "Marco Antonio Rubio (born May 28, 1971) is the junior United States Senator from Florida, serving since January 2011, and a candidate for President of the United States." },
	bush: { first_name: "Jeb", last_name: "Bush", twitter_handle: "JebBush", party: "Republican", bio: "John Ellis 'Jeb' Bush (born February 11, 1953) is an American businessman and politician who served as the 43rd Governor of Florida from 1999 to 2007." },
	huckabee: { first_name: "Mike", last_name: "Huckabee", twitter_handle: "GovMikeHuckabee", party: "Republican", bio: "Michael Dale 'Mike' Huckabee (born August 24, 1955) is an American politician, Christian minister, author, and commentator who served as the 44th Governor of Arkansas from 1996 to 2007." },
	paul: { first_name: "Rand", last_name: "Paul", twitter_handle: "RandPaul", party: "Republican", bio: "Randal Howard 'Rand' Paul (born January 7, 1963) is an American politician and physician." },
	jindal: { first_name: "Bobby", last_name: "Jindal", twitter_handle: "BobbyJindal", party: "Republican", bio: "Piyush 'Bobby' Jindal (born June 10, 1971) is an American politician who is the 55th governor of Louisiana, a former US Congressman, and former vice chairman of the Republican Governors Association." },
	kasich: { first_name: "John", last_name: "Kasich", twitter_handle: "JohnKasich", party: "Republican", bio: "John Richard Kasich (born May 13, 1952) is an American politician and the 69th and current Governor of Ohio, elected to the office in 2010 and reelected in the 2014 election. On July 21, 2015, he announced his candidacy for the Republican nomination for president in 2016." },
	christie: { first_name: "Chris", last_name: "Christie", twitter_handle: "GovChristie", party: "Republican", bio: "Christopher James 'Chris' Christie (born September 6, 1962) is the 55th Governor of New Jersey. He has been governor since January 2010 and was re-elected for a second term in the 2013 election." },
	santorum: { first_name: "Rick", last_name: "Santorum", twitter_handle: "RickSantorum", party: "Republican", bio: "Richard John 'Rick' Santorum (born May 10, 1958) is an American attorney and Republican Party politician." },
	gilmore: { first_name: "Jim", last_name: "Gilmore", twitter_handle: "gov_gilmore", party: "Republican", bio: "James Stuart 'Jim' Gilmore III (born October 6, 1949) is an American politician who was the 68th Governor of Virginia from 1998 to 2002." },
	graham: { first_name: "Lindsey", last_name: "Graham", twitter_handle: "LindseyGrahamSC", party: "Republican", bio: "Lindsey Olin Graham (born July 9, 1955) is an American politician and member of the Republican Party, who has served as a United States Senator from South Carolina since 2003, and has been the senior Senator from South Carolina since 2005." },
	pataki: { first_name: "George", last_name: "Pataki", twitter_handle: "GovernorPataki", party: "Republican", bio: "George Elmer Pataki (born June 24, 1945) is an American lawyer and politician who served as the 53rd Governor of New York (1995–2006)." },

	clinton: { first_name: "Hillary", last_name: "Clinton", twitter_handle: "HillaryClinton", party: "Democrat", bio: "Hillary Diane Rodham Clinton (born October 26, 1947) is an American politician who served as the 67th United States Secretary of State under President Barack Obama from 2009 to 2013. " },
	sanders: { first_name: "Bernie", last_name: "Sanders", twitter_handle: "SenSanders", party: "Democrat", bio: "Bernard 'Bernie' Sanders (born September 8, 1941) is an American politician and the junior United States Senator from Vermont." },
	omalley: { first_name: "Martin", last_name: "O'Malley", twitter_handle: "MartinOMalley", party: "Democrat", bio: "Martin Joseph O'Malley (born January 18, 1963) was the 61st Governor of Maryland, from 2007 to 2015, and is running for President of the United States in the 2016 election." },
	chafee: { first_name: "Lincoln", last_name: "Chafee", twitter_handle: "LincolnChafee", party: "Democrat", bio: "Lincoln Davenport Chafee (born March 26, 1953) is an American politician from Rhode Island who has served as the Mayor of Warwick (1993–1999), a U.S. Senator (1999–2007) and as the 74th Governor of Rhode Island (2011–2015)." },
	webb: { first_name: "Jim", last_name: "Webb", twitter_handle: "JimWebbUSA", party: "Democrat", bio: "James Henry 'Jim' Webb, Jr. (born February 9, 1946) is an American politician and author." }
}

CATEGORIES = [
	{
		name: "unemployment",
		keywords: ["unemployment", "unemployed", "welfare", "homelessness", "poverty", "hunger", "labor", "wage", "retire", "hire" ]
	},
	{
		name: "economy",
		keywords: ["tax", "taxes" "refund", "wealth", "inheritance", "cuts", "interest", "irs", "economy", "audit", "fiscal", "budgetary", "evasion", "deductible", "1099" ]
	},
	{
		name: "health care",
		keywords: ["health", "healthcare", "obamacare", "medicare", "medicaid", "insurance", "abortion", "zadroga", "addiction", "epidemic", "parenthood", "drug", "pharmaceutical", "doctor"]
	},
	{
		name: "corporate crime",
		keywords: ["corporate", "lobbying", "contractors", "business", "koch", "launder", "embezzle", "bribe", "insider", "privatization" ]
	},
	{
		name: "terrorism",
		keywords: ["terror", "terrorism", "isis", "bengazi", "cyberterrorism", "drone", "islamist", "threat"]
	},
	{
		name: "foreign policy",
		keywords: ["foreign", "china", "cuba", "trade", "afghanistan", "international", "diplomacy", "overseas", "commerce", "embassy"]
	},
	{
		name: "immigration",
		keywords: ["immigration", "immigrant", "undocumented", "illegal", "border", "citizenship", "naturalization", "alien", "deport", "mexico", "visa"]
	},
	{
		name: "climate change",
		keywords: ["climate", "energy", "keystone", "green", "recycling", "drilling", "solar", "environment", "fuel", "atmosphere", "pollution", ""]
	},
	{
		name: "education",
		keywords: ["education", "testing", "stem", "technology", "university", "vouchers", "student", "teachers", "college", "campus", "tuition"]
	},
	{
		name: "race relations",
		keywords: ["african", "ferguson", "racism", "incarceration", "diversity", "black", "hispanic", "voting"]
	},
	{
		name: "lgbt rights",
		keywords: ["marriage", "equality", "homosexual", "gay", "transgender", "lesbian", "legalization", "tradition", "bisexual"]
	}
]

# # ======================================================================
#
# Seed candidates
candidates = []
CANDIDATES.each do |candidate, info|
	candidates << Candidate.create!(info)
end

# Seed categories and keywords
categories = []
CATEGORIES.each do |category|
	new_category = Category.create!(name: category[:name])
	category[:keywords].each do |keyword|
		new_category.keywords.create!(word: keyword)
	end
	categories << new_category
end

# # ======================================================================
#
# # Pull tweets and write to files
# client = TwitterAPI.client
#
# tweets = {}
#
# CANDIDATES.each do |candidate, candidate_info|
# 	begin
# 		tweets[candidate] = TwitterAPI.get_all_tweets(candidate_info[:twitter_handle])
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

# ======================================================================

# # Parse files and write to masters
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
#
# # ======================================================================
#
# # IO.popen("python ~/DEV Bootcamp/Phase 3/politips-final-project/db/nlp_runner.py development")
#
# # ======================================================================
#
# Write categories data to json file
# def write_categories_data_to_json
# 	categories_data = {}
# 	Candidate.all.each do |candidate|
# 		categories_data[candidate.last_name] = { }
# 		categories_data[candidate.last_name]["children"] = candidate.categories_data
# 	end
# 	File.open("public/categories_data.json", "w") do |file|
# 		file << categories_data.to_json
# 	end
# end
#
# write_categories_data_to_json
