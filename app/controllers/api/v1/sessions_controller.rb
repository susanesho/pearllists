class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { message: 'logged in' }
    else
      render json: { error: 'user not found' }
    end
  end

  def destroy
    session.clear
    render json: { message: 'logged out successfully' }
  end
end
