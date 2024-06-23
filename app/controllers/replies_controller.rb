class RepliesController < ApplicationController
  before_action :logged_in_user

  def create
    @review = Review.find(params[:reply][:review_id])
    @reply = @review.replies.build(reply_params)
    @reply.user = current_user
    if @reply.save
      redirect_to root_url
    else
      # @reviews = @heritage.reviews
      # render 'heritages/show', status: :unprocessable_entity
    end
  end

  def destroy
    Reply.find(params[:id]).destroy
    redirect_to root_url, status: :see_other
  end

  private

  def reply_params
    params.require(:reply).permit(:content, :review_id, reply_images: [])
  end
end
