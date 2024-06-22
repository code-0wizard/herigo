require 'rails_helper'

RSpec.describe 'HeritageSecondCharms', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/heritage_second_charms/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/heritage_second_charms/edit'
      expect(response).to have_http_status(:success)
    end
  end
end
