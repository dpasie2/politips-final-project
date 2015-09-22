class Candidate < ActiveRecord::Base
  has_many :scorings
  has_many :categories, through: :scorings

  def self.get_party_members(party)
   Candidate.where(party: party)
  end
end
