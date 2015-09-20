class Candidate < ActiveRecord::Base
  has_many :scorings
  has_many :categories, through: :scorings
end
