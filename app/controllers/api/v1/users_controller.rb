class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      token = user.generate_auth_token
      Token.create(token: token, user_id: user.id)
      render(
        json: {
          name: user.name,
          email: user.email,
          message: message.account_created,
          token: token
        },
        status: 200
      )
    else
      render json: user.errors, status: 400
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
