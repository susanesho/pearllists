require "rails_helper"
RSpec.describe "Create User", type: :request do
  before(:all) do
    @user = create(:user)
  end

  after(:all) do
    User.destroy_all
  end

  describe "Post /users" do
    context "when creating a user with valid params" do
      it "creates new user" do
        post(
          "/api/v1/users/",
          name: "tayelolu",
          email: "tayelolu@gmail.com",
          password: "tayeloluejire345"
        )
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_response["name"]).to eq "tayelolu"
      end
    end

    context "when creating a user with invalid params" do
      it "renders error message and does not create user" do
        post(
          "/api/v1/users/",
          name: "tayelolu",
          email: "",
          password: "tayeloluejire345"
        )
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(400)
        expect(json_response["email"]).to eq ["can't be blank"]
      end
    end
  end
end
