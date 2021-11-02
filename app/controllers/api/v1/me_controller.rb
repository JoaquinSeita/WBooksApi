module Api
  module V1
    class MeController < ApplicationController
      before_action :authenticate_user!

      def index
        render json: current_user
      end

      def update
        render json: current_user, status: :no_content if current_user.update me_params
      end

      def me_params
        params.require(:user).permit(:email, :first_name, :last_name, :password, :image_url,
                                     :locale)
      end
    end
  end
end
