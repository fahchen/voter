class HomeController < ApplicationController
  before_filter :signed_in_user, only: [:index, :cast_votes, :create_votes, :latest_votes]
  def index
  	@create_votes = current_user.votes.limit(5)
  	@cast_votes = current_user.cast_votes.limit(5)
  	@last_votes = Vote.order("created_at DESC").limit(5)
  end
  def about
  end
  def contact
  end

  def cast_votes
    @cast_votes = current_user.cast_votes.paginate(per_page: 15,page: params[:page])
  end
  def create_votes
    @create_votes = current_user.votes.paginate(per_page: 15,page: params[:page])
  end
  def latest_votes
    @latest_votes = Vote.paginate(per_page: 15, page: params[:page], order: "created_at DESC")
  end

end
