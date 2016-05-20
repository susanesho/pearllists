class Api::V1::SessionsController < ApplicationController
  before_action :authenticate, only: [:destroy]

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = user.generate_auth_token
      Token.create(token: token, user_id: user.id)
      render(
        json: {
          message: message.login_success,
          token: token
        },
        status: 200
      )
    else
      render json: { error: message.no_user_found }, status: 403
    end
  end

  def destroy
    token = Token.find_by(user_id: current_user.id)
    token.destroy
    render json: { message: message.logout_success }, status: 200
  end
end
