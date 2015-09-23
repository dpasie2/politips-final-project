class Category < ActiveRecord::Base
  has_many :scorings
  has_many :candidates, through: :scorings
  has_many :keywords

  def keywords_search_operator
    keywords_string = ""
    self.keywords.each do |keyword|
      keywords_string.empty? ? keywords_string << keyword.word : keywords_string << " OR #{keyword.word}"
    end
    keywords_string
  end

end
