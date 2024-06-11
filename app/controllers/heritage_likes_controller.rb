class HeritageLikesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:show]

  def show
    user = User.find(params[:id])
    @bookmark_heritages = user.heritages
  end

  def create
    heritage = Heritage.find(params[:heritage_id])
    current_user.like_heritage(heritage)
    redirect_to heritage
  end

  def destroy
    heritage = Heritage.find(params[:heritage_id])
    current_user.unlike_heritage(heritage)
    redirect_to heritage
  end
end
