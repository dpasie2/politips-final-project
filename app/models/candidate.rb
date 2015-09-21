class Candidate < ActiveRecord::Base
  has_many :scorings
  has_many :categories, through: :scorings

  def format_candidate
<<<<<<< HEAD
    candidate = {name: "#{self.name}", party: "#{self.party}", children:"[{category: #{self.category}, scoring: #{self.scoring}}]"}
=======
    candidate = { name: "#{self.name}", party: "#{self.party}", children:[{}] }
>>>>>>> master
  end

  def self.get_party_members(party)
   Candidate.where(party: party)
  end
end
