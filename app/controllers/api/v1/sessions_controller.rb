class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = user.generate_auth_token
      render json: { token: token }, status: 200
    else
      render json: { error: "user not found" }, status: 403
    end
  end

  def destroy
    session.clear
    render json: { message: "logged out successfully" }, status: 200
  end
end
