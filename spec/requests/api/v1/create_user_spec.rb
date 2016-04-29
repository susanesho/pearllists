require "rails_helper"
RSpec.describe "Create Bucketlist", type: :request do
  before(:all) do
    @user = create(:user)
  end

  after(:all) do
    User.destroy_all
  end

  describe "Post /users" do
    context "valid params" do
      it "creates new users" do
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

    context "invalid params" do
      it "creates a user" do
        post(
          "/api/v1/users/",
          name: "tayelolu",
          email: "",
          password: "tayeloluejire345"
        )
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(422)
        expect(json_response["email"]).to eq ["can't be blank"]
      end
    end
  end
end