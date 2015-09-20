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

unemployment.keywords << Keyword.create!(keyword: "unemployment")
unemployment.keywords << Keyword.create!(keyword: "reform")
unemployment.keywords << Keyword.create!(keyword: "welfare")
unemployment.keywords << Keyword.create!(keyword: "homelessness")
unemployment.keywords << Keyword.create!(keyword: "poverty")
unemployment.keywords << Keyword.create!(keyword: "hunger")
unemployment.keywords << Keyword.create!(keyword: "labor")
unemployment.keywords << Keyword.create!(keyword: "union")

taxes.keywords << Keyword.create!(keyword: "tax")
taxes.keywords << Keyword.create!(keyword: "refund")
taxes.keywords << Keyword.create!(keyword: "wealth")
taxes.keywords << Keyword.create!(keyword: "inheritance")
taxes.keywords << Keyword.create!(keyword: "cuts")
taxes.keywords << Keyword.create!(keyword: "interest")
taxes.keywords << Keyword.create!(keyword: "IRS")
taxes.keywords << Keyword.create!(keyword: "reform")

health.keywords << Keyword.create!(keyword: "obamacare")
health.keywords << Keyword.create!(keyword: "medicare")
health.keywords << Keyword.create!(keyword: "medicaid")
health.keywords << Keyword.create!(keyword: "insurance")
health.keywords << Keyword.create!(keyword: "abortion")

corp.keywords << Keyword.create!(keyword: "corporate")
corp.keywords << Keyword.create!(keyword: "curruption")
corp.keywords << Keyword.create!(keyword: "lobbying")
corp.keywords << Keyword.create!(keyword: "inequality")
corp.keywords << Keyword.create!(keyword: "wages")

terrorism.keywords << Keyword.create!(keyword: "terrorism")
terrorism.keywords << Keyword.create!(keyword: "isis")
terrorism.keywords << Keyword.create!(keyword: "bengazi")
terrorism.keywords << Keyword.create!(keyword: "iran")
terrorism.keywords << Keyword.create!(keyword: "cyberterrorism")
terrorism.keywords << Keyword.create!(keyword: "islam")

foreign.keywords << Keyword.create!(keyword: "foreign")
foreign.keywords << Keyword.create!(keyword: "china")
foreign.keywords << Keyword.create!(keyword: "cuba")
foreign.keywords << Keyword.create!(keyword: "trade")
foreign.keywords << Keyword.create!(keyword: "afghanistan")

immigration.keywords << Keyword.create!(keyword: "immigration")
immigration.keywords << Keyword.create!(keyword: "reform")
immigration.keywords << Keyword.create!(keyword: "undocumented")
immigration.keywords << Keyword.create!(keyword: "illegal")

climate.keywords << Keyword.create!(keyword: "climate")
climate.keywords << Keyword.create!(keyword: "energy")
climate.keywords << Keyword.create!(keyword: "keystone")
climate.keywords << Keyword.create!(keyword: "green")

education.keywords << Keyword.create!(keyword: "education")
education.keywords << Keyword.create!(keyword: "testing")
education.keywords << Keyword.create!(keyword: "stem")
education.keywords << Keyword.create!(keyword: "technology")
education.keywords << Keyword.create!(keyword: "reform")
education.keywords << Keyword.create!(keyword: "vouchers")

race.keywords << Keyword.create!(keyword: "race")
race.keywords << Keyword.create!(keyword: "ferguson")
race.keywords << Keyword.create!(keyword: "racism")
race.keywords << Keyword.create!(keyword: "incarceration")
race.keywords << Keyword.create!(keyword: "diversity")
race.keywords << Keyword.create!(keyword: "black")
race.keywords << Keyword.create!(keyword: "hispanic")

marriage.keywords << Keyword.create!(keyword: "marriage")
marriage.keywords << Keyword.create!(keyword: "equality")
marriage.keywords << Keyword.create!(keyword: "homosexual")
marriage.keywords << Keyword.create!(keyword: "gay")
marriage.keywords << Keyword.create!(keyword: "transgender")
marriage.keywords << Keyword.create!(keyword: "lesbian")
marriage.keywords << Keyword.create!(keyword: "legalization")
marriage.keywords << Keyword.create!(keyword: "tradition")
