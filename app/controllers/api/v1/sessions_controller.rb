class Api::V1::SessionsController < ApplicationController
  before_action :authenticate, only: [:destroy]

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = user.generate_auth_token
      Token.create(token: token, user_id: user.id)
      render(
        json: {
          message: "logged in successfully",
          token: token
        },
        status: 200
      )
    else
      render json: { error: "user not found" }, status: 403
    end
  end

  def destroy
    token = Token.find_by(user_id: current_user.id)
    token.destroy
    render json: { message: "logged out successfully" }, status: 200
  end
end
