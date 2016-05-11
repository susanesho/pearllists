module Modify
  def update_lists(list, name)
    if list
      if list.update(name: params[:name])
        render json: list, status: 200
      else
        render json:  list.errors, status: 400
      end
    else
      render json: { error: "#{name} does not exist" }, status: 404
    end
  end

  def destroy_lists(list, name)
    if list && list.destroy
      render json: { message: "#{name} destroyed" }, status: 200
    else
      render json: { error: "#{name} was not destroyed" }, status: 404
    end
  end
end
