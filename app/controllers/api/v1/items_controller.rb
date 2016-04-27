class Api::V1::ItemsController < ApplicationController
  before_action :authenticate

  def create
    item = Item.new(item_params)
    bucketlist = Bucketlist.find_by(id: params[:bucketlist_id])

    if check_bucketlist
      item.bucketlist_id = bucketlist.id

      if item.save
        render json: item, status: 200
      else
        render json: item.errors, status: 422
      end

    else
      render json: { error: "bucket item cannot be created" }, status: 403
    end
  end

  def update
    item = Item.find_by(id: params[:id])

    if item && check_bucketlist
      item.update(item_params)
      render json: item, status: 201
    else
      render json: { error: "cannot update item" }, status: 403
    end
  end

  def destroy
    item = Item.find_by(id: params[:id])

    if item && check_bucketlist
      item.destroy
      render json: { message: "item destroyed" }, status: 200
    else
      render json: { error: "cannot destroy item" }, status: 403
    end
  end

  private

  def check_bucketlist
    bucketlist = Bucketlist.find_by(id: params[:bucketlist_id])

    if bucketlist
      bucketlist.user_bucket?(current_user)
    end
  end

  def item_params
    params.permit(:name, :done)
  end
end
