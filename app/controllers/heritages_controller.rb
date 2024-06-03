class HeritagesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :admin_user,     only: [:new, :create]

  def index
    @heritages = Heritage.all
    @continents = Continent.all
  end

  def show
    @heritage = Heritage.find(params[:id])
    @reviews = @heritage.reviews
    @review = @heritage.reviews.build
    @heritage_first_charm = @heritage.heritage_first_charm
    @heritage_second_charm = @heritage.heritage_second_charm
    @heritage_third_charm = @heritage.heritage_third_charm
    @heritage_fourth_charm = @heritage.heritage_fourth_charm
  end

  def new
    @heritage = Heritage.new
  end

  def create
    country = Country.find_by(name: heritage_params[:country])
    @heritage = country.heritages.build(heritage_params.except(:country).merge(country_id: country.id))
    if @heritage.save
      flash[:info] = "世界遺産登録完了しました"
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @heritage = Heritage.find(params[:id])
    @country_name = Country.find(@heritage.country_id).name
  end

  def update
  end

  private
    def heritage_params
      params.require(:heritage).permit(:name, :content, :country, images: [])
    end
end
