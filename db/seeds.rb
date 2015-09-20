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

bush = Candidate.create!(first_name: "Jeb", last_name: "Bush", party: "Republican", bio: "John Ellis 'Jeb' Bush (born February 11, 1953) is an American businessman and politician who served as the 43rd Governor of Florida from 1999 to 2007.")
carson = Candidate.create!(first_name: "Ben", last_name: "Carson", party: "Republican", bio: "Benjamin Solomon 'Ben' Carson, Sr. (born September 18, 1951) is an American author, politician, and retired Johns Hopkins neurosurgeon.")
chafee = Candidate.create!(first_name: "Lincoln", last_name: "Chafee", party: "Democrat", bio: "Lincoln Davenport Chafee (born March 26, 1953) is an American politician from Rhode Island who has served as the Mayor of Warwick (1993–1999), a U.S. Senator (1999–2007) and as the 74th Governor of Rhode Island (2011–2015).")
christie = Candidate.create!(first_name: "Chris", last_name: "Christie", party: "Republican", bio: "Christopher James 'Chris' Christie (born September 6, 1962) is the 55th Governor of New Jersey. He has been governor since January 2010 and was re-elected for a second term in the 2013 election.")
clinton = Candidate.create!(first_name: "Hillary", last_name: "Clinton", party: "Democrat", bio: "Hillary Diane Rodham Clinton (born October 26, 1947) is an American politician who served as the 67th United States Secretary of State under President Barack Obama from 2009 to 2013. ")
cruz = Candidate.create!(first_name: "Ted", last_name: "Cruz", party: "Republican", bio: "Rafael Edward 'Ted' Cruz (born December 22, 1970) is the junior U.S. Senator from Texas.")
fiorina = Candidate.create!(first_name: "Carly", last_name: "Fiorina", party: "Republican", bio: "Carly Fiorina (born Cara Carleton Sneed, September 6, 1954) is an American Republican politician and former business executive who currently chairs the non-profit philanthropic organization Good360.")
gilmore = Candidate.create!(first_name: "Jim", last_name: "Gilmore", party: "Republican", bio: "James Stuart 'Jim' Gilmore III (born October 6, 1949) is an American politician who was the 68th Governor of Virginia from 1998 to 2002.")
graham = Candidate.create!(first_name: "Lindsey", last_name: "Graham", party: "Republican", bio: "Lindsey Olin Graham (born July 9, 1955) is an American politician and member of the Republican Party, who has served as a United States Senator from South Carolina since 2003, and has been the senior Senator from South Carolina since 2005.")
huckabee = Candidate.create!(first_name: "Mike", last_name: "Huckabee", party: "Republican", bio: "Michael Dale 'Mike' Huckabee (born August 24, 1955) is an American politician, Christian minister, author, and commentator who served as the 44th Governor of Arkansas from 1996 to 2007.")
jindal = Candidate.create!(first_name: "Bobby", last_name: "Jindal", party: "Republican", bio: "Piyush 'Bobby' Jindal (born June 10, 1971) is an American politician who is the 55th governor of Louisiana, a former US Congressman, and former vice chairman of the Republican Governors Association.")
kasich = Candidate.create!(first_name: "John", last_name: "Kasich", party: "Republican", bio: "John Richard Kasich (born May 13, 1952) is an American politician and the 69th and current Governor of Ohio, elected to the office in 2010 and reelected in the 2014 election. On July 21, 2015, he announced his candidacy for the Republican nomination for president in 2016.")
omalley = Candidate.create!(first_name: "Martin", last_name: "O'Malley", party: "Democrat", bio: "Martin Joseph O'Malley (born January 18, 1963) was the 61st Governor of Maryland, from 2007 to 2015, and is running for President of the United States in the 2016 election.")
pataki = Candidate.create!(first_name: "George", last_name: "Pataki", party: "Republican", bio: "George Elmer Pataki (born June 24, 1945) is an American lawyer and politician who served as the 53rd Governor of New York (1995–2006).")
paul = Candidate.create!(first_name: "Rand", last_name: "Paul", party: "Republican", bio: "Randal Howard 'Rand' Paul (born January 7, 1963) is an American politician and physician.")
rubio = Candidate.create!(first_name: "Marco", last_name: "Rubio", party: "Republican", bio: "Marco Antonio Rubio (born May 28, 1971) is the junior United States Senator from Florida, serving since January 2011, and a candidate for President of the United States.")
sanders = Candidate.create!(first_name: "Bernie", last_name: "Sanders", party: "Democrat", bio: "Bernard 'Bernie' Sanders (born September 8, 1941) is an American politician and the junior United States Senator from Vermont.")
santorum = Candidate.create!(first_name: "Rick", last_name: "Santorum", party: "Republican", bio: "Richard John 'Rick' Santorum (born May 10, 1958) is an American attorney and Republican Party politician.")
trump = Candidate.create!(first_name: "Donald", last_name: "Trump", party: "Republican", bio: "Donald John Trump (born June 14, 1946) is an American real estate developer, television personality, business author and political candidate.")
walker = Candidate.create!(first_name: "Scott", last_name: "Walker", party: "Republican", bio: "Scott Kevin Walker (born November 2, 1967) is the 45th Governor of Wisconsin, serving since 2011, and a candidate for the Republican Party's nomination to the 2016 presidential election.")
webb = Candidate.create!(first_name: "Jim", last_name: "Webb", party: "Democrat", bio: "James Henry 'Jim' Webb, Jr. (born February 9, 1946) is an American politician and author.")


### Seeding fake scores for D3 work ####









#####



unemployment = Category.create!(name: "Unemployment")
taxes = Category.create!(name: "Taxes")
health = Category.create!(name: "Health Care")
corp = Category.create!(name: "Corporate Corruption")
terrorism = Category.create!(name: "Terrorism")
foreign = Category.create!(name: "Foreign Policy")
immigration = Category.create!(name: "Immigration")
climate = Category.create!(name: "Climate Change")
education = Category.create!(name: "Education")
race = Category.create!(name: "Race Relations")
marriage = Category.create!(name: "Marriage Equality")

unemployment.keywords << Keyword.create!(word: "unemployment")
unemployment.keywords << Keyword.create!(word: "reform")
unemployment.keywords << Keyword.create!(word: "welfare")
unemployment.keywords << Keyword.create!(word: "homelessness")
unemployment.keywords << Keyword.create!(word: "poverty")
unemployment.keywords << Keyword.create!(word: "hunger")
unemployment.keywords << Keyword.create!(word: "labor")
unemployment.keywords << Keyword.create!(word: "union")

taxes.keywords << Keyword.create!(word: "tax")
taxes.keywords << Keyword.create!(word: "refund")
taxes.keywords << Keyword.create!(word: "wealth")
taxes.keywords << Keyword.create!(word: "inheritance")
taxes.keywords << Keyword.create!(word: "cuts")
taxes.keywords << Keyword.create!(word: "interest")
taxes.keywords << Keyword.create!(word: "irs")
taxes.keywords << Keyword.create!(word: "reform")

health.keywords << Keyword.create!(word: "obamacare")
health.keywords << Keyword.create!(word: "medicare")
health.keywords << Keyword.create!(word: "medicaid")
health.keywords << Keyword.create!(word: "insurance")
health.keywords << Keyword.create!(word: "abortion")

corp.keywords << Keyword.create!(word: "corporate")
corp.keywords << Keyword.create!(word: "curruption")
corp.keywords << Keyword.create!(word: "lobbying")
corp.keywords << Keyword.create!(word: "inequality")
corp.keywords << Keyword.create!(word: "wages")

terrorism.keywords << Keyword.create!(word: "terrorism")
terrorism.keywords << Keyword.create!(word: "isis")
terrorism.keywords << Keyword.create!(word: "bengazi")
terrorism.keywords << Keyword.create!(word: "iran")
terrorism.keywords << Keyword.create!(word: "cyberterrorism")
terrorism.keywords << Keyword.create!(word: "islam")

foreign.keywords << Keyword.create!(word: "foreign")
foreign.keywords << Keyword.create!(word: "china")
foreign.keywords << Keyword.create!(word: "cuba")
foreign.keywords << Keyword.create!(word: "trade")
foreign.keywords << Keyword.create!(word: "afghanistan")

immigration.keywords << Keyword.create!(word: "immigration")
immigration.keywords << Keyword.create!(word: "reform")
immigration.keywords << Keyword.create!(word: "undocumented")
immigration.keywords << Keyword.create!(word: "illegal")

climate.keywords << Keyword.create!(word: "climate")
climate.keywords << Keyword.create!(word: "energy")
climate.keywords << Keyword.create!(word: "keystone")
climate.keywords << Keyword.create!(word: "green")

education.keywords << Keyword.create!(word: "education")
education.keywords << Keyword.create!(word: "testing")
education.keywords << Keyword.create!(word: "stem")
education.keywords << Keyword.create!(word: "technology")
education.keywords << Keyword.create!(word: "reform")
education.keywords << Keyword.create!(word: "vouchers")

race.keywords << Keyword.create!(word: "race")
race.keywords << Keyword.create!(word: "ferguson")
race.keywords << Keyword.create!(word: "racism")
race.keywords << Keyword.create!(word: "incarceration")
race.keywords << Keyword.create!(word: "diversity")
race.keywords << Keyword.create!(word: "black")
race.keywords << Keyword.create!(word: "hispanic")

marriage.keywords << Keyword.create!(word: "marriage")
marriage.keywords << Keyword.create!(word: "equality")
marriage.keywords << Keyword.create!(word: "homosexual")
marriage.keywords << Keyword.create!(word: "gay")
marriage.keywords << Keyword.create!(word: "transgender")
marriage.keywords << Keyword.create!(word: "lesbian")
marriage.keywords << Keyword.create!(word: "legalization")
marriage.keywords << Keyword.create!(word: "tradition")
