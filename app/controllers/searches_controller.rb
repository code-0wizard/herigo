class SearchesController < ApplicationController
  def search
    query = "%#{search_params[:query]}%"
    @records = Heritage.where('name LIKE ?', query)
    @continents = Continent.all
    @search_words = search_params[:query]
  end

  private
    def search_params
      params.permit(:query)
    end
end
