class CandidatesController < ApplicationController
  before_action :find_all_candidates, only: [:index]

  def index
  end

  def tweets
    candidate = Candidate.find_by(last_name: params[:last_name])
    category_name = params[:category].split(" ").map { |word| word.capitalize }.join(" ")
    category = Category.find_by(name: category_name)
    puts "tweet tweet #{category.name}"
    p category.keywords
    response = candidate.load_tweet_ids_for(category)
    respond_to do |format|
      format.json { render json: response }
    end
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
end
