class HeritagesController < ApplicationController

  def index
    @heritages = Heritage.paginate(page: params[:page])
  end

  def show
    @heritage = Heritage.find(params[:id])
    @reviews = @heritage.reviews
    @review = @heritage.reviews.build
  end
end
