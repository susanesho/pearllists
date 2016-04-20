class Api::V1::BucketlistsController < ApplicationController
  def create
    bucketlist = Bucketlist.create(bucketlist_params)
    render json: bucketlist
  end

  private

  def bucketlist_params
    params.permit(:name)
  end
end
