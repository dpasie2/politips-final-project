a = "BAIER: So tonight, you can't say if another one of these...

PAUL: This is what's wrong!

BAIER: OK.

PAUL: I mean, this is what's wrong. He buys and sells politicians of all stripes, he's already...

BAIER: Dr. Paul.

PAUL: Hey, look, look! He's already hedging his bet on the Clintons, OK? So if he doesn't run as a Republican, maybe he supports Clinton, or maybe he runs as an independent...

BAIER: OK.

PAUL: ...but I'd say that he's already hedging his bets because he's used to buying politicians.

TRUMP: Well, I've given him plenty of money.

BAIER: Just to be clear, you can't make a -- we're gonna -- we're going to move on.

You're not gonna make the pledge tonight?

TRUMP: I will not make the pledge at this time."

quotes = a.split(/(^[A-Z]+:)/)
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
