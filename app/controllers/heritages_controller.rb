class HeritagesController < ApplicationController

  def show
    @heritage = Heritage.find(params[:id])
    @reviews = @heritage.reviews
    @review = @heritage.reviews.build
  end
end
