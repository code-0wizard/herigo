class ReviewsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :destroy

  def create
    @heritage = Heritage.find(params[:heritage_id])
    @review = @heritage.reviews.build(review_params)
    @review.user = current_user
    # @review.review_images.attach(params[:review][:review_images]) これがあると同じ画像を2枚保存しちゃう
    if @review.save
      redirect_to root_url
    else
      @reviews = @heritage.reviews
      render 'heritages/show', status: :unprocessable_entity
    end
  end

  def show
    @review = Review.find(params[:id])
    @heritage = @review.heritage
    @reply = Reply.new
    @replies = Reply.where(review_id: params[:id])
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to root_url, status: :see_other
  end

  private

  def review_params
    params.require(:review).permit(:content, :score, review_images: [])
  end

  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @review.nil?
  end
end
