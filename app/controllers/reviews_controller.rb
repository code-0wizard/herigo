class ReviewsController < ApplicationController
  before_action :logged_in_user

  def create
    heritage = Heritage.find(params[:heritage_id])
    review = heritage.reviews.build(review_params)
    review.user = current_user
    review.review_image.attach(params[:review][:review_image])
    if review.save
      flash[:success] = "口コミが投稿されました"
      redirect_to root_url
    else
      render 'heritages/show', status: :unprocessable_entity
    end
  end

  private
    def review_params
      params.require(:review).permit(:content, :review_image)
    end
end
