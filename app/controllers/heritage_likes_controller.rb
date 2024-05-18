class HeritageLikesController < ApplicationController
  before_action :logged_in_user

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
