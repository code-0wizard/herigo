class HeritageSecondCharmsController < ApplicationController
  def new
    @heritage_second_charm = HeritageSecondCharm.new
  end

  def create
    heritage = Heritage.find(heritage_second_charm_params[:heritage_id])
    @heritage_second_charm = heritage.build_heritage_second_charm(heritage_second_charm_params)
    @heritage_second_charm.image.attach(params[:heritage_second_charm][:image])
    if @heritage_second_charm.save
      flash[:success] = "2つ目の魅力が登録完了しました。"
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

  def heritage_second_charm_params
    params.require(:heritage_second_charm).permit(:main_title, :sub_title, :detail, :heritage_id, :image)
  end
end
