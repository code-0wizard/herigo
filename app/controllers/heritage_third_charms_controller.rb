class HeritageThirdCharmsController < ApplicationController
  def new
    @heritage_third_charm = HeritageThirdCharm.new
  end

  def create
    heritage = Heritage.find(heritage_third_charm_params[:heritage_id])
    @heritage_third_charm = heritage.build_heritage_third_charm(heritage_third_charm_params)
    @heritage_third_charm.image.attach(params[:heritage_third_charm][:image])
    if @heritage_third_charm.save
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

  def heritage_third_charm_params
    params.require(:heritage_third_charm).permit(:main_title, :sub_title, :detail, :heritage_id, :image)
  end
end
