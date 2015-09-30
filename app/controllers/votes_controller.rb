class VotesController < ApplicationController
  before_action :authorize!

  def create
    vote = Vote.create(user_id: current_user.id, episode_id: params[:episode_id])
    flash[:warning] = "You already upvoted this episode." if vote.invalid?
    redirect_to episodes_path
  end
end
