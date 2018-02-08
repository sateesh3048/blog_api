class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate  

  #return auth token once user is authenticated
  def authenticate
    expires_in = 30.seconds.to_i
    expires_in = 24.hours.from_now.to_i
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password], expires_in).call
    json_response({auth_token: auth_token, expires_in: expires_in})
  end

  private
  def auth_params
    params.permit(:email, :password)
  end
end
