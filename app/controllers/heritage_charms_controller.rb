class HeritageCharmsController < ApplicationController
  def index
  end

  def new
    @heritage_charms = Array.new(4) do
      heritage_charm = HeritageCharm.new
      heritage_charm.main_image.build
      heritage_charm.sub_image.build
      heritage_charm
    end
  end

  def create
    debugger
    heritage = Heritage.find(params[:heritage_id])
    @heritage_charms = params[:heritage_charms].map do |heritage_charm_param|
      heritage_charm = heritage.heritage_charms.build(heritage_charm_param.permit(:title, :description, :order))
      heritage_charm.main_image.attach(heritage_charm_param[:main_image])
      heritage_charm.sub_image.attach(heritage_charm_param[:sub_image])
      heritage_charm
    end
    if @heritage_charms.all?(&:save)
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
  end
end
