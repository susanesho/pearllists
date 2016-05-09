class Api::V1::ItemsController < ApplicationController
  before_action :authenticate
  before_action :check_bucketlist

  def create
    item = Item.new(item_params)
    item.bucketlist_id = @bucketlist.id

    if item.save
      render json: item, status: 201
    else
      render json: item.errors, status: 400
    end
  end

  def update
    item = Item.find_by(id: params[:id])

    if item
      if item.update(item_params)
        render json: item, status: 200
      else
        render json: item.errors, status: 400
      end
    else
      render json: { error: "item does not exist" }, status: 404
    end
  end

  def destroy
    item = Item.find_by(id: params[:id])

    if item && item.destroy
      render json: { message: "item destroyed" }, status: 200
    else
      render json: { error: "item was not destroyed" }, status: 400
    end
  end

  private

  def check_bucketlist
    @bucketlist = Bucketlist.find_by(id: params[:bucketlist_id])

    unless @bucketlist && @bucketlist.user_bucket?(current_user)
      render json: { error: "Unauthorized" }, status: 403
    end
  end

  def item_params
    params.permit(:name, :done)
  end
end
