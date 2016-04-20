class ApplicationController < ActionController::API
  attr_reader :current_user

  def authenticate
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
    else
      render json: { message: "you are not logged in" }
    end
  end
end
