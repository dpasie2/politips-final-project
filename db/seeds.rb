# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# require "twitter"
#
# TWITTER_HANDLES = {
# 	sanders: "@SenSanders",
# 	clinton: "@HillaryClinton",
# 	chafee: "@LincolnChafee",
# 	omalley: "@MartinOMalley",
# 	webb: "@JimWebbUSA",
# 	bush: "@JebBush",
# 	carson: "@RealBenCarson",
# 	christie: "@GovChristie",
# 	cruz: "@SenTedCruz",
# 	fiorina: "@CarlyFiorina",
# 	gilmore: "@gov_gilmore",
# 	graham: "@LindseyGrahamSC",
# 	huckabee: "@GovMikeHuckabee",
# 	jindal: "@BobbyJindal",
# 	kasich: "@JohnKasich",
# 	pataki: "@GovernorPataki",
# 	paul: "@RandPaul",
# 	rubio: "@marcorubio",
# 	santorum: "@RickSantorum",
# 	trump: "@realDonaldTrump",
# 	walker: "@ScottWalker"
# }
#
#
# client = Twitter::REST::Client.new do |config|
# 	config.consumer_key			= Rails.application.secrets.twitter_consumer_key
# 	config.consumer_secret	= Rails.application.secrets.twitter_consumer_secret
# end
#
# raw_text = {}
#
# TWITTER_HANDLES.each do |candidate, handle|
# 	raw_text[candidate] = client.user_timeline(handle, count: 200, include_rts: false).map { |tweet| tweet.text }
# end
#
# raw_text.each { |candidate, tweets| p tweets.count }


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

unemployment.keywords << Keyword.create!(name: "unemployment")
unemployment.keywords << Keyword.create!(name: "reform")
unemployment.keywords << Keyword.create!(name: "welfare")
unemployment.keywords << Keyword.create!(name: "homelessness")
unemployment.keywords << Keyword.create!(name: "poverty")
unemployment.keywords << Keyword.create!(name: "hunger")
unemployment.keywords << Keyword.create!(name: "labor")
unemployment.keywords << Keyword.create!(name: "union")

taxes.keywords << Keyword.create!(name: "tax")
taxes.keywords << Keyword.create!(name: "refund")
taxes.keywords << Keyword.create!(name: "wealth")
taxes.keywords << Keyword.create!(name: "inheritance")
taxes.keywords << Keyword.create!(name: "cuts")
taxes.keywords << Keyword.create!(name: "interest")
taxes.keywords << Keyword.create!(name: "IRS")
taxes.keywords << Keyword.create!(name: "reform")

health.keywords << Keyword.create!(name: "obamacare")
health.keywords << Keyword.create!(name: "medicare")
health.keywords << Keyword.create!(name: "medicaid")
health.keywords << Keyword.create!(name: "insurance")
health.keywords << Keyword.create!(name: "abortion")

corp.keywords << Keyword.create!(name: "corporate")
corp.keywords << Keyword.create!(name: "curruption")
corp.keywords << Keyword.create!(name: "lobbying")
corp.keywords << Keyword.create!(name: "inequality")
corp.keywords << Keyword.create!(name: "wages")

terrorism.keywords << Keyword.create!(name: "terrorism")
terrorism.keywords << Keyword.create!(name: "isis")
terrorism.keywords << Keyword.create!(name: "bengazi")
terrorism.keywords << Keyword.create!(name: "iran")
terrorism.keywords << Keyword.create!(name: "cyberterrorism")
terrorism.keywords << Keyword.create!(name: "islam")

foreign.keywords << Keyword.create!(name: "foreign")
foreign.keywords << Keyword.create!(name: "china")
foreign.keywords << Keyword.create!(name: "cuba")
foreign.keywords << Keyword.create!(name: "trade")
foreign.keywords << Keyword.create!(name: "afghanistan")

immigration.keywords << Keyword.create!(name: "immigration")
immigration.keywords << Keyword.create!(name: "reform")
immigration.keywords << Keyword.create!(name: "undocumented")
immigration.keywords << Keyword.create!(name: "illegal")

climate.keywords << Keyword.create!(name: "climate")
climate.keywords << Keyword.create!(name: "energy")
climate.keywords << Keyword.create!(name: "keystone")
climate.keywords << Keyword.create!(name: "green")

education.keywords << Keyword.create!(name: "education")
education.keywords << Keyword.create!(name: "testing")
education.keywords << Keyword.create!(name: "stem")
education.keywords << Keyword.create!(name: "technology")
education.keywords << Keyword.create!(name: "reform")
education.keywords << Keyword.create!(name: "vouchers")

race.keywords << Keyword.create!(name: "race")
race.keywords << Keyword.create!(name: "ferguson")
race.keywords << Keyword.create!(name: "racism")
race.keywords << Keyword.create!(name: "incarceration")
race.keywords << Keyword.create!(name: "diversity")
race.keywords << Keyword.create!(name: "black")
race.keywords << Keyword.create!(name: "hispanic")

marriage.keywords << Keyword.create!(name: "marriage")
marriage.keywords << Keyword.create!(name: "equality")
marriage.keywords << Keyword.create!(name: "homosexual")
marriage.keywords << Keyword.create!(name: "gay")
marriage.keywords << Keyword.create!(name: "transgender")
marriage.keywords << Keyword.create!(name: "lesbian")
marriage.keywords << Keyword.create!(name: "legalization")
marriage.keywords << Keyword.create!(name: "tradition")
