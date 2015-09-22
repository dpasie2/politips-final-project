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
  ##scroll in the candidates nav bar

  def tweets
    @candidate = Candidate.find_by(last_name: params[:last_name])
    @category = Category.find_by(name: params[:category])
    TwitterAPI.search_tweets_for(@candidate.twitter_handle, @category.keywords)
  end
end
