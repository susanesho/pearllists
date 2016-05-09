require "rails_helper"
RSpec.describe "Create Bucketlist", type: :request do
  before(:all) do
    @user = create(:user)
    @token = set_login(@user)
  end

  after(:all) do
    User.destroy_all
    Bucketlist.destroy_all
  end

  describe "Post /bucketlists" do
    context "valid params" do
      it "creates a bucketlist" do
        post(
          "/api/v1/bucketlists/",
          { name: "bucket1" },
          HTTP_AUTHORIZATION: @token
        )
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(201)
        expect(json_response["bucketlist"]["name"]).to eq "bucket1"
        expect(json_response["bucketlist"]["created_by"]).to eq @user.id
      end
    end

    context "invalid params" do
      it "renders error and does not create bucketlist" do
        post(
          "/api/v1/bucketlists/",
          nil,
          HTTP_AUTHORIZATION: @token
        )
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(400)
        expect(json_response["name"]).to eq ["can't be blank"]
      end
    end

    context "no authorization token" do
      it "renders unauthorized access error" do
        post(
          "/api/v1/bucketlists/",
          name: "bucket1"
        )
        json_response = JSON.parse(response.body)

        expect(json_response["error"]).to eq "unauthorized access"
        expect(response).to have_http_status(401)
      end
    end
  end
end
