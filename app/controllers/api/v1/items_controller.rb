class Api::V1::ItemsController < ApplicationController
  include Modifier
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
    update_list(item, "item")
  end

  def destroy
    item = Item.find_by(id: params[:id])
    destroy_list(item, "item")
  end

  private

  def check_bucketlist
    @bucketlist = Bucketlist.find_by(id: params[:bucketlist_id])

    unless @bucketlist && @bucketlist.user_bucket?(current_user)
      render json: { error: message.check_user_bucket }, status: 403
    end
  end

  def item_params
    params.permit(:name, :done)
  end
end
