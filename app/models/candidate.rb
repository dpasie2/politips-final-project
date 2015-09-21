class Candidate < ActiveRecord::Base
  has_many :scorings
  has_many :categories, through: :scorings

  def format_candidate
    candidate = { name: "#{self.name}", party: "#{self.party}", children:[{}] }
  end

  def self.get_party_members(party)
   Candidate.where(party: party)
  end
end
