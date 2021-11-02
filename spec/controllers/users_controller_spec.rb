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
end
