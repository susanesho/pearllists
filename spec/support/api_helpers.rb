require "rails_helper"
module ApiHelpers
  def set_login(user)
    post "/api/v1/auth/login", email: user.email, password: user.password
    json_response = JSON.parse(response.body)
    json_response["token"]
  end

  def create_bucketlist(_user, token, n = 10)
    n.times do
      post(
        "/api/v1/bucketlists",
        { name: Faker::Company.buzzword },
        HTTP_AUTHORIZATION: token
      )
    end
    @bucketlist = Bucketlist.last
  end

  def create_item(_user, token, n = 1)
    n.times do
      post(
        "/api/v1/bucketlists/#{@bucketlist.id}/items",
        { name: Faker::Company.buzzword },
        HTTP_AUTHORIZATION: token
      )
    end
  end
end
