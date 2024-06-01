class HeritagesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :admin_user,     only: [:new, :create]

  def index
    @heritages = Heritage.paginate(page: params[:page])
  end

  def show
    @heritage = Heritage.find(params[:id])
    @reviews = @heritage.reviews
    @review = @heritage.reviews.build
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

  private
    def heritage_params
      params.require(:heritage).permit(:name, :content, :country, images: [])
    end
end
