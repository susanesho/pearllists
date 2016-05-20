require "rails_helper"
module ApiHelpers
  def set_login(user)
    post "/api/v1/auth/login", email: user.email, password: user.password
    json_response["token"]
  end

  def json_response
    JSON.parse(response.body)
  end

  def message
    @message ||= Messages.new
  end
end
