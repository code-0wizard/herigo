class HeritagesController < ApplicationController
  before_action :logged_in_user, only: %i[new create]
  before_action :admin_user,     only: %i[new create]

  def index
    @heritages = Heritage.all
    @continents = Continent.all
  end

  def show
    @heritage = Heritage.find(params[:id])
    @reviews = @heritage.reviews
    @review = @heritage.reviews.build
    @continents = Continent.all
    @heritage_first_charm = @heritage.heritage_charms.find_by(order: 1)
    @heritage_second_charm = @heritage.heritage_charms.find_by(order: 2)
    @heritage_third_charm = @heritage.heritage_charms.find_by(order: 3)
    @heritage_fourth_charm = @heritage.heritage_charms.find_by(order: 4)
  end

  def new
    @heritage = Heritage.new
  end

  def create
    country = Country.find_by(name: heritage_params[:country])
    @heritage = country.heritages.build(heritage_params.except(:country).merge(country_id: country.id))
    if @heritage.save
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
    @heritage = Heritage.find(params[:id])
    country_id = Country.find_by(name: params[:heritage][:country]).id
    if @heritage.update(heritage_params.merge(country_id:))
      @heritage.heritage_tags.destroy_all
      create_heritage_tags(params[:id], params[:heritage][:tag_ids])
      redirect_to root_url
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def heritage_params
    params.require(:heritage).permit(:name, :content, :lat, :lng, :pc_image, :mobile_image, slideshow_images: [])
  end

  def create_heritage_tags(heritage_id, tag_ids)
    return if tag_ids.blank?

    tag_ids.each do |tag_id|
      HeritageTag.create(heritage_id:, tag_id:)
    end
  end
end
