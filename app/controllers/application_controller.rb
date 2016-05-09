class ApplicationController < ActionController::API
  include ActionController::Serialization
  attr_reader :current_user

  def authenticate
    if decoded_auth_token && valid_token
      @current_user ||= User.find_by(id: decoded_auth_token["user_id"])
    else
      render json: { error: "unauthorized access" }, status: 401
    end
  end

  def decoded_auth_token
    @decoded_auth_token ||= AuthToken.decode(auth_token)
  end

  def auth_token
    if request.headers["Authorization"].present?
      request.headers["Authorization"].split(" ").last
    end
  end

  def valid_token
    Token.find_by(token: auth_token)
  end

  def no_route_found
    render(
      json: {
        error: "Invalid address specify a valid endpoint!"
      },
      status: 404
    )
  end
end
