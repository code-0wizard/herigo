class ContinentsController < ApplicationController
  def show
    @tags = Tag.all
    @continent = Continent.find(params[:id])
    @tag_id = params[:tag_id] unless params[:tag_id].nil?
    if !params[:tag_id].nil? 
      @tag_id = params[:tag_id]
      tag = Tag.find(@tag_id)
      @heritages = tag.heritages
    else
      @heritages = Heritage.all
    end
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
