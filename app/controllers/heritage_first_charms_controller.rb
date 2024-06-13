class HeritageFirstCharmsController < ApplicationController
  def new
    @heritage_first_charm = HeritageFirstCharm.new
  end

  def create
    heritage = Heritage.find(heritage_first_charm_params[:heritage_id])
    @heritage_first_charm = heritage.build_heritage_first_charm(heritage_first_charm_params)
    @heritage_first_charm.image.attach(params[:heritage_first_charm][:image])
    if @heritage_first_charm.save
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

  def heritage_first_charm_params
    params.require(:heritage_first_charm).permit(:main_title, :sub_title, :detail, :heritage_id, :image)
  end
end
