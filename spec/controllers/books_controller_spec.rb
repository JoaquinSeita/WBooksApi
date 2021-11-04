require 'rails_helper'

describe Api::V1::BooksController, type: :controller do
  include_context 'Authenticated User'
  include_context 'User, Book and Rent'

  describe 'GET #index' do
    context 'When fetching all the books' do
      let!(:books) { create_list(:book, 5) }

      before do
        get :index, params: { page: 1, per_page: 5 }
      end

      it 'responses with the books json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          books, each_serializer: BookSerializer
        ).to_json
        expect(response.body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'When fetching a book' do
      before do
        get :show, params: { id: book.id }
      end

      it 'responses with the book json' do
        expect(response.body.to_json) =~ BookSerializer.new(
          book, root: false
        ).to_json
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When fetching a invalid book' do
      before do
        get :show, params: { id: 'book.id' }
      end

      it 'responds with 404 status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
