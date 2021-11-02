require 'rails_helper'

describe Api::V1::MeController, type: :controller do
  include_context 'Authenticated User'
  include_context 'User, Book and Rent'

  describe 'GET #index' do
    context 'When fetching the current user' do
      before do
        get :index
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When fetching and not loged' do
      let!(:auth_headers) { '' }
      before do
        request.headers['Authorization'] = auth_headers['Authorization']
        get :index
      end

      it 'responds with 401 status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH #update' do
    context 'When updating the current user' do
      before do
        params = { user: { first_name: user.first_name } }
        patch :update, params: params, as: :json
      end

      it 'responds with 204 status' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'When fetching and not loged' do
      let!(:auth_headers) { '' }
      before do
        params = { user: { first_name: user.first_name } }
        request.headers['Authorization'] = auth_headers['Authorization']
        patch :update, params: params, as: :json
      end

      it 'responds with 401 status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
