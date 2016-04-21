class ApplicationController < ActionController::API
  attr_reader :current_user

  def authenticate
    if decoded_auth_token
      @current_user ||= User.find_by(id: decoded_auth_token["user_id"])
    else
      render json: { error: "unauthorized access" }
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
end
