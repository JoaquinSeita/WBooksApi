module Api
  module V1
    class RentsController < ApplicationController
      before_action :authenticate_user!

      include RentsControllerHelper

      def index
        render json: Rent.page(page).per(per_page), each_serializer: RentSerializer,
               status: :ok
      end

      def create
        return unless valid_user?(rent_params[:user_id]) && valid_book?(rent_params[:book_id])

        book = Book.find(rent_params[:book_id])
        user = User.find(rent_params[:user_id])
        rent_book(book, user) if valid_date? && book_available?(book)
      end

      def show
        render json: Rent.find(params[:id]), serializer: RentSerializer if valid_rent?(params[:id])
      end

      def destroy
        return unless valid_rent?(params[:id])

        rent = Rent.find(params[:id])
        rent_cancel(rent)
      end
    end
  end
end
