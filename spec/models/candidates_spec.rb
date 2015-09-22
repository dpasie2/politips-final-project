require 'rails_helper'

describe Candidate do
  let (:sample_candidate){Candidate.new(first_name: "Scott", last_name: "Walker", party: "Republican", bio: "Dropped out of presidential race", twitter_handle: "@scottwalker")}
  context "create a new candidate" do
    it "can create a candidate" do
      expect(sample_candidate.valid?).to be_truthy
    end
  end


  context "associations" do
    trump = Candidate.create(first_name: "Donald", last_name: "Trump", party: "Republican", bio: "Rich", twitter_handle: "@thetrump")
    trump.scorings.create(score: 25, category_id: 1)
    it "can create a scoring through association" do
      expect(trump.scorings.first.score).to eq(25)
    end
  end




end
