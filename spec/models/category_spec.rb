require 'rails_helper'

describe Category do
  let (:sample_category){Category.new(name: "gay marriage")}
  context "create a new category" do
    it "can create a category" do
      expect(sample_category.valid?).to be_truthy
    end

    it "assigns an id to a category once saved" do
      sample_category.save
      expect(sample_category.name).to eq("gay marriage")
    end
  end


  context "category associations" do
    it "has keywords" do
      category = Category.new(name: "gay marriage")
      category.save
      category.keywords.create(word: "equality")
      expect(category.keywords.first.word).to eq("equality")
    end

    it "has scorings" do
      category = Category.new(name: "gay marriage")
      category.save
      category.scorings.create(score: 25)
      expect(category.scorings.first.score).to eq(25)
    end

  end
end
