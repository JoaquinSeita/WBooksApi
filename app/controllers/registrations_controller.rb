class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.save
    render_resource(resource)
  end

  def sign_up_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :image_url, :locale)
  end
end
