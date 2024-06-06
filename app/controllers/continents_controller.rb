class ContinentsController < ApplicationController
  def show
    @heritages = Heritage.all
  end
  
  def edit
    @continent = Continent.find(params[:id])
  end

  def update
    @continent = Continent.find(params[:id])
    @continent.image.attach(params[:continent][:image])
    if @continent.update(continent_params)
      flash[:success] = "写真の登録が完了しました。"
      redirect_to root_url
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def continent_params
    params.require(:continent).permit(:image)
  end
end
