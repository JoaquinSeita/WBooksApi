module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!

      def show
        render json: User.find(params[:id])
      end

      def profile
        render json: current_user
      end

      def update_profile
        raise ActionController::ParameterMissing, profile_params if profile_params.empty?
        return render json: current_user, status: :ok if current_user.update profile_params

        render json: current_user.errors, status: :unprocessable_entity
      end

      def profile_params
        params.require(:user).permit(:email, :first_name, :last_name, :image_url,
                                     :locale)
      end
    end
  end
end
