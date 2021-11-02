module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!

      def show
        render json: User.find(params[:id]) if valid_user?(params[:id])
      end
    end
  end
end
