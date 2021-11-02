require 'rails_helper'

describe Api::V1::RentsController, type: :controller do
  include_context 'Authenticated User'
  include_context 'User, Book and Rent'

  describe 'GET #index' do
    context 'When fetching all the rents' do
      let!(:rents) { create_list(:rent, 5, user_id: user.id, book_id: book.id) }

      before do
        get :index, params: { page: 1, per_page: 5 }
      end

      it 'responses with the rents json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          rents, each_serializer: RentSerializer
        ).to_json
        expect(response.body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'When fetching a rent' do
      before do
        get :show, params: { id: rent.id }
      end

      it 'responses with the book json' do
        expect(response.body.to_json) =~ RentSerializer.new(
          rent, root: false
        ).to_json
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    context 'When create a valid rent' do
      before do
        params = { rent: { from: Time.zone.today, to: Time.zone.today + 1, book_id: book.id,
                           user_id: user.id } }
        post :create, params: params, as: :json
      end

      it 'responses with the book json' do
        expect(response.body.to_json) =~ RentSerializer.new(
          rent, root: false
        ).to_json
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When create a invalid rent' do
      it 'invalid "to" date responds with 422' do
        params = { rent: { from: Time.zone.today, to: Time.zone.today - 1, book_id: book.id,
                           user_id: user.id } }
        post :create, params: params, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'invalid "from" date responds with 422' do
        params = { rent: { from: Time.zone.today - 1, to: Time.zone.today, book_id: book.id,
                           user_id: user.id } }
        post :create, params: params, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'invalid "user_id" responds with 404' do
        params = { rent: { from: Time.zone.today, to: Time.zone.today, book_id: book.id,
                           user_id: 'user.id' } }
        post :create, params: params, as: :json
        expect(response).to have_http_status(:not_found)
      end

      it 'invalid "book_id" responds with 404' do
        params = { rent: { from: Time.zone.today, to: Time.zone.today, book_id: 'book.id',
                           user_id: user.id } }
        post :create, params: params, as: :json
        expect(response).to have_http_status(:not_found)
      end

      it 'book not available responds with 422' do
        book.update!(available: false)
        params = { rent: { from: Time.zone.today, to: Time.zone.today, book_id: book.id,
                           user_id: user.id } }
        post :create, params: params, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When cancel a valid rent' do
      before do
        delete :destroy, params: { id: rent.id }
      end

      let(:parsed_body) { JSON.parse(response.body) }

      it 'rent.book.available has to be true' do
        expect(parsed_body['book']['available']).to eq(true)
      end

      it 'rent.book.returned_at has to be Time.zone.today' do
        expect(parsed_body['returned_at'].to_date).to eq(Time.zone.today)
      end

      it 'responses with the rent json' do
        expect(response.body.to_json) =~ RentSerializer.new(
          rent, root: false
        ).to_json
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When cancel a invalid rent' do
      it 'invalid "rent_id" responds with 404' do
        delete :destroy, params: { id: 'rent_id' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
