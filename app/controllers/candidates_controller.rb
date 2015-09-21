class CandidatesController < ApplicationController
  before_action :find_all_candidates, only: [:index]

  def index
  end

  # def data
  #   respond_to do |format|
  #     format.json {
  #       render :json
  #     }
  #   end
  # end

  private

  def find_all_candidates
    @candidates = Candidate.all
  end
  ##scroll in the candidats nav bar
end
