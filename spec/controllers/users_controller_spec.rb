require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  include_context 'Authenticated User'
  include_context 'User, Book and Rent'

  describe 'GET #show' do
    context 'When fetching a valid user' do
      before do
        get :show, params: { id: user.id }
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When fetching a invalid user' do
      before do
        get :show, params: { id: 'user.id' }
      end

      it 'responds with 404 status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET #profile' do
    context 'When fetching the current user' do
      before do
        get :profile
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When fetching and not loged' do
      let!(:auth_headers) { '' }
      before do
        request.headers['Authorization'] = auth_headers['Authorization']
        get :profile
      end

      it 'responds with 401 status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH #update_profile' do
    context 'When updating the current user' do
      before do
        params = { user: { first_name: user.first_name } }
        patch :update_profile, params: params, as: :json
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When updating and params not valid' do
      before do
        params = { user: { first_nae: user.first_name } }
        patch :update_profile, params: params, as: :json
      end

      it 'responds with 400 status' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'When updating and params are empty' do
      before do
        params = {}
        patch :update_profile, params: params, as: :json
      end

      it 'responds with 400 status' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'When updating and a param is empty' do
      before do
        params = { first_name: '' }
        patch :update_profile, params: params, as: :json
      end

      it 'responds with 422 status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When updating and not loged' do
      let!(:auth_headers) { '' }
      before do
        params = { user: { first_name: user.first_name } }
        request.headers['Authorization'] = auth_headers['Authorization']
        patch :update_profile, params: params, as: :json
      end

      it 'responds with 401 status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
