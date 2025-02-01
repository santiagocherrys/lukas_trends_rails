require 'rails_helper'

RSpec.describe 'Tests', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/test/index'
      expect(response).to have_http_status(:success)
    end
  end
end
