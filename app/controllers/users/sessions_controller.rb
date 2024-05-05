# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  include RackSessionsFix

  def respond_with(resource, _opt = {})
    @token = request.env['warden-jwt_auth.token']

    render json: {
      message: 'Logged in successfully.',
      token: @token,
      data: {
        user: resource.as_json().merge!({token: @token}),
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, ENV['devise_jwt_secret_key']).first
      current_user = User.find(jwt_payload['sub'])
    end
    
    if current_user
      render json: {
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
 
end
