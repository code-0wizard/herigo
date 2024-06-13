class HeritageFourthCharmsController < ApplicationController
  def new
    @heritage_fourth_charm = HeritageFourthCharm.new
  end

  def create
    heritage = Heritage.find(heritage_fourth_charm_params[:heritage_id])
    @heritage_fourth_charm = heritage.build_heritage_fourth_charm(heritage_fourth_charm_params)
    @heritage_fourth_charm.image.attach(params[:heritage_fourth_charm][:image])
    if @heritage_fourth_charm.save
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  private

  def heritage_fourth_charm_params
    params.require(:heritage_fourth_charm).permit(:main_title, :sub_title, :detail, :heritage_id, :image)
  end
end
