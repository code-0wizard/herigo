class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @review = Review.find(params[:review_id])
    current_user.like_review(@review)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    current_user.unlike_review(@review)
    respond_to do |format|
      format.js
    end
  end
end
