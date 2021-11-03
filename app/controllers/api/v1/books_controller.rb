module Api
  module V1
    class BooksController < ApplicationController
      before_action :authenticate_user!

      def index
        render json: Book.page(page).per(per_page), each_serializer: BookSerializer, status: :ok
      end

      def show
        render json: Book.find(params[:id]), serializer: BookSerializer
      end
    end
  end
end
