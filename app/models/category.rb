class Category < ActiveRecord::Base
  has_many :scorings
  has_many :candidates, through: :scorings
end
