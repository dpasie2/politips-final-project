class CandidatesController < ApplicationController
  before_action :find_all_candidates, only: [:index]

  def index
  end

  private

  def find_all_candidates
    @candidates = Candidate.all
  end
end