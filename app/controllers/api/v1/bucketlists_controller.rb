class Api::V1::BucketlistsController < ApplicationController
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
      render json: { error: "no buckets found" }, status: 404
    else
      render json: bucketlists, status: 200
    end
  end

  def show
    bucketlist = Bucketlist.find_by(id: params[:id], user_id: current_user.id)

    if bucketlist
      render json: bucketlist, status: 200
    else
      render json: { error: "no bucket found" }, status: 404
    end
  end

  def update
    bucketlist = Bucketlist.find_by(id: params[:id], user_id: current_user.id)

    if bucketlist
      if bucketlist.update(bucketlist_params)
        render json: bucketlist, status: 201
      else
        render json:  bucketlist.errors, status: 400
      end
    else
      render json: { error: "bucketlist does not exist" }, status: 404
    end
  end

  def destroy
    bucketlist = Bucketlist.find_by(id: params[:id], user_id: current_user.id)

    if bucketlist && bucketlist.destroy
      render json: { message: "bucket has been destroyed" }, status: 200
    else
      render json: { error: "bucket was not destroyed" }, status: 404
    end
  end

  private

  def bucketlist_params
    params.permit(:name)
  end
end
