class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    review = Review.find(params[:review_id])
    current_user.like_review(review)
    heritage = Heritage.find(review.heritage_id)
    redirect_to heritage
    # respond_to do |format|
    #   format.html { redirect_to current_user }
    #   format.turbo_stream
    # end
  end

  def destroy
    review = Review.find(params[:review_id])
    current_user.unlike_review(review)
    heritage = Heritage.find(review.heritage_id)
    redirect_to heritage
    # respond_to do |format|
    #   format.html { redirect_to current_user, status: :see_other }
    #   format.turbo_stream
    # end
  end
end
