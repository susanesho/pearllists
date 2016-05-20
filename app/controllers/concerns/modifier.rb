module Modifier
  def update_list(list, name)
    if list
      if list.update(name: params[:name])
        render json: list, status: 200
      else
        render json:  list.errors, status: 400
      end
    else
      render json: {
        error: message.update_message(list, name)
      }, status: 404
    end
  end

  def destroy_list(list, name)
    if list && list.destroy
      render json: {
        message: message.delete_success_message(list, name)
      }, status: 200
    else
      render json: {
        error: message.delete_error_message(list, name)
      }, status: 404
    end
  end
end
