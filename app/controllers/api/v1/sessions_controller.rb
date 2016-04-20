class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email], name: params[:name])
    if user
      render json: user
    else
      render json: { error: "user not found" }
    end
  end

  def destroy
    session.clear
    render json: { message: "logged out successfully" }
  end
end
