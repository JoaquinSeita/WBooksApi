class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActionController::ParameterMissing, with: :params_missing
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def params_missing
    render json: { 'error': 'Parameters cannot be empty!' }, status: :bad_request
  end

  def record_not_found
    render json: { 'error': 'Record not found!' }, status: :not_found
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name image_url locale])
  end

  def render_resource(resource)
    return render json: resource if resource.errors.empty?

    validation_error(resource)
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end

  def unprocessable_entity(error_content)
    render json: {
      "error": error_content.to_s
    }, status: :unprocessable_entity
  end

  def page
    @page ||= params[:page] || 1
  end

  def per_page
    @per_page ||= params[:per_page] || 10
  end
end
