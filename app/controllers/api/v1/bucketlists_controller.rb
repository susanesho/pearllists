class Api::V1::BucketlistsController < ApplicationController
  before_action :authenticate

  def create
    bucketlist = Bucketlist.new(bucketlist_params)
    bucketlist.user_id = current_user.id
    if bucketlist.save
      render json: bucketlist
    else
      render json:  bucketlist.errors
    end
  end

  def index
    bucketlists = current_user.bucketlists

    if bucketlists.empty?
      render json: { error: "no bucket have been created" }
    else
      render json: bucketlists
    end
  end

  def show
    bucketlist = Bucketlist.find_by(id: params[:id])

    if bucketlist && bucketlist.user == current_user
      render json: bucketlist
    else
      render json: { error: "no bucket found" }
    end
  end

  def update
    bucketlist = Bucketlist.find_by(id: params[:id])

    if bucketlist && bucketlist.user == current_user
      bucketlist.update(bucketlist_params)
      bucketlist.save
      render json: { message: "succesfully updated" }
    else
      render json: { error: "could not update bucketlist" }
    end
  end

  def destroy
    bucketlist = Bucketlist.find_by(id: params[:id])

    if bucketlist && bucketlist.user == current_user
      bucketlist.destroy
      render json: { message: "bucket have been destroyed" }
    else
      render json: { error: "bucket was not destroyed" }
    end
  end

  private

  def bucketlist_params
    params.permit(:name)
  end
end
