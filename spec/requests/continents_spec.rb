require 'rails_helper'

RSpec.describe "Continents", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/continents/new"
      expect(response).to have_http_status(:success)
    end
  end

end
