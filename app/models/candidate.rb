class Candidate < ActiveRecord::Base
  has_many :scorings
  has_many :categories, through: :scorings

  def format_candidate
    candidate = {name: "#{self.name}", party: "#{self.party}", children:"[{category: #{self.category}, scoring: #{self.scoring}}]"}
  end

end
