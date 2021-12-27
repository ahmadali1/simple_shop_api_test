require "rails_helper"

# TODO: Modify it to use it for other actions too, not only for :index
RSpec.shared_examples "JWT Validations" do |action_name|
  let(:user) { create(:user) }
  let(:jwt_header) do
    jwt = JWT.encode({ user_id: user.id }, ENV.fetch('SECRET_KEY_BASE'))
    {'Authorization': "Bearer #{jwt}" }
  end

  it 'returns ok status with valid jwt token' do
    get action_name, headers: jwt_header, as: :json

    expect(response).to have_http_status(:ok)
  end

  it 'returns unauthorized status with no jwt token' do
    get action_name, as: :json

    expect(response).to have_http_status(:unauthorized)
  end

  it 'returns unauthorized status with invalid jwt token' do
    get action_name, headers: {'Authorization': "Bearer asdf" }, as: :json

    expect(response).to have_http_status(:unauthorized)
  end
end

RSpec.describe Api::V1::OrdersController, type: :request do
  let(:parsed_response) { JSON.parse(response.body) }
  describe '#index' do
    include_examples "JWT Validations", '/api/v1/orders'

    before do
      create(:order, customer: user)
    end

    it 'returns valid orders' do
      get '/api/v1/orders', headers: jwt_header, as: :json

      expect(response).to have_http_status(:ok)
      expect(parsed_response.length).to eq(1)
      expect(parsed_response.first.keys).to eq(["id", "status", "shipping_address", "price", "paid_at"])
    end
    # TODO: write spec for create(:order, :with_products_and_order_items) | index | show
  end

  describe '#create' do
    let(:user) { create(:user) }
    let(:jwt_header) do
      jwt = JWT.encode({ user_id: user.id }, ENV.fetch('SECRET_KEY_BASE'))
      {'Authorization': "Bearer #{jwt}" }
    end
    let(:product) { create(:product, :with_region) }
    let(:params) do
      {
        shipping_address: 'Some shipping Address',
        order_items_attributes: [
          {
            product_id: product.id,
            quantity: 1
          }
        ]
      }
    end

    it 'created order with order items' do
      post '/api/v1/orders', params: params, headers: jwt_header, as: :json

      expect(response).to have_http_status(:created)
    end
  end

  # TODO: Implement all actions!
end
