class Candidate < ActiveRecord::Base
  has_many :scorings
  has_many :categories, through: :scorings

  def self.get_party_members(party)
   Candidate.where(party: party)
  end

  def search_tweets_for(category)

  end

  def categories_data
    sum = 0
    self.scorings.each { |scoring| sum += scoring.score }
    self.scorings.map do |scoring|
      value = (scoring.score.to_f / sum.to_f * 100).round
      value = 1 if value == 0
      { "issue" => scoring.category.name.downcase, "value" => (scoring.score.to_f / sum.to_f * 100).round }
    end
  end

end
