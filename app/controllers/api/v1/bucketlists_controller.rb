class Api::V1::BucketlistsController < ApplicationController

  def create
    bucketlist = Bucketlist.create(bucketlist_params)
    render json: bucketlist
  end

   def index
    bucketlists = Bucketlist.all

    if bucketlists
      render json: bucketlists
    else
      render json: { error: "no bucket have been created" }
    end
  end

  def show
    bucketlist = Bucketlist.find_by(id: params[:id])
    if bucketlist
      render json: bucketlist
    else
      render json: { error: "no bucket found" }
    end
  end

  def update
  bucketlist = Bucketlist.find_by(id: params[:id])

    if bucketlist
      bucketlist.update(bucketlist_params)
      bucketlist.save
      render json: { message: "succesfully updated" }
    else
      render json: { error: "could not update bucketlist" }
    end
  end

  private

  def bucketlist_params
    params.permit(:name)
  end
end
