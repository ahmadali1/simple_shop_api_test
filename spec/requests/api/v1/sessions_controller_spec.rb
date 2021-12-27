require "rails_helper"

RSpec.describe Api::V1::SessionsController, type: :request do
  describe '#create' do
    before { create(:user, email: 'ahmad@ali.com', password: 'password') }

    it 'returns token with valid credentials' do
      post '/api/v1/login', params: { email: 'ahmad@ali.com', password: 'password' }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['token']).not_to be_empty
    end

    it 'returns 422 invalid credentials' do
      post '/api/v1/login', params: { email: 'ahmad@ali.com', password: 'abc' }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
