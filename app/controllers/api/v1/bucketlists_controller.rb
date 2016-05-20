class Api::V1::BucketlistsController < ApplicationController
  include Modifier
  before_action :authenticate

  def create
    bucketlist = Bucketlist.new(bucketlist_params)
    bucketlist.user_id = current_user.id
    if bucketlist.save
      render json: bucketlist, status: 201
    else
      render json:  bucketlist.errors, status: 400
    end
  end

  def index
    bucketlists = current_user.bucketlists.search(params[:q]).paginate(params)

    if bucketlists.empty?
      render json: { error: message.no_bucket_found }, status: 404
    else
      render json: bucketlists, status: 200
    end
  end

  def show
    bucketlist = Bucketlist.find_by(id: params[:id], user_id: current_user.id)

    if bucketlist
      render json: bucketlist, status: 200
    else
      render json: { error: message.no_bucket_found }, status: 404
    end
  end

  def update
    bucketlist = Bucketlist.find_by(id: params[:id], user_id: current_user.id)
    update_list(bucketlist, "bucket")
  end

  def destroy
    bucketlist = Bucketlist.find_by(id: params[:id], user_id: current_user.id)
    destroy_list(bucketlist, "bucket")
  end

  private

  def bucketlist_params
    params.permit(:name)
  end
end
