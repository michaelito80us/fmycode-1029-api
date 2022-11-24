# app/controllers/api/v1/base_controller.rb
class Api::V1::BaseController < ActionController::Base
  skip_before_action :verify_authenticity_token

  rescue_from StandardError,                with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def internal_server_error(exception)
    response = if Rails.env.development?
                 { type: exception.class.to_s, error: exception.message }
               else
                 { error: 'Internal Server Error' }
               end
    render json: response, status: :internal_server_error
  end
end
