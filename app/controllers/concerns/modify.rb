module Modify
  def update_lists(list)
    if list.update(name: params[:name])
      render json: list, status: 200
    else
      render json:  list.errors, status: 400
    end
  end

  def destroy_lists(list)
    if list.destroy
      render json: { message: "#{list.class.name.downcase} destroyed" }, status: 200
    end
  end
end