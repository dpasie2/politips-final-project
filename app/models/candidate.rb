class Candidate < ActiveRecord::Base
  has_many :scorings
  has_many :categories, through: :scorings

  def self.get_party_members(party)
   Candidate.where(party: party)
  end

  def load_tweet_ids_for(category)
    client = Twitter::REST::Client.new do |config|
    	config.consumer_key			= Rails.application.secrets.twitter_consumer_key
    	config.consumer_secret	= Rails.application.secrets.twitter_consumer_secret
    end
    puts category.keywords_search_operator
    tweets = client.search("from:#{self.twitter_handle} #{category.keywords_search_operator}").take(5)
    tweets.map { |tweet| tweet.id.to_s }
  end

  def categories_data
    sum = 0
    self.scorings.each { |scoring| sum += scoring.score }
    self.scorings.map do |scoring|
      value = (scoring.score.to_f / sum.to_f * 100).round
      value = 1 if value == 0
      { "issue" => scoring.category.name.downcase, "value" => value }
    end
  end

end
