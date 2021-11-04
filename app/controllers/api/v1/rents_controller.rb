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
        raise ActionController::ParameterMissing, rent_params if rent_params.empty?

        book = Book.find(rent_params[:book_id])
        rent_book(book) unless reject_unprocessable_entity(book)
      end

      def show
        render json: Rent.find(params[:id]), serializer: RentSerializer
      end

      def destroy
        rent = Rent.find(params[:id])
        rent_cancel(rent)
      end

      def rent_params
        params.require(:rent).permit(:to, :from, :book_id)
      end

      private

      def reject_unprocessable_entity(book)
        unless rent_params[:from] && rent_params[:to]
          return unprocessable_entity('You must provide to and from dates')
        end
        return unprocessable_entity('The book is not available right now') unless book.available
        return unprocessable_entity('The dates are not valid') unless valid_date?
      end
    end
  end
end
