require "rails_helper"
RSpec.describe "Create Items", type: :request do
  before(:all) do
    @user = create(:user)
    @token = set_login(@user)
  end

  after(:all) do
    User.destroy_all
    Bucketlist.destroy_all
  end

  describe "Post /items" do
    context "valid params" do
      it "creates an item" do
        create_bucketlist(@user, @token, 10)
        bucketlist = Bucketlist.last

        post(
          "/api/v1/bucketlists/#{bucketlist.id}/items",
          { name: "mynames" },
          HTTP_AUTHORIZATION: @token
        )
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(201)
        expect(json_response["item"]["name"]).to eq "mynames"
      end
    end

    context "invalid params" do
      it "renders error and does not create items" do
        create_bucketlist(@user, @token, 1)
        bucketlist = Bucketlist.last

        post(
          "/api/v1/bucketlists/#{bucketlist.id}/items",
          { name: "" },
          HTTP_AUTHORIZATION: @token
        )
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(400)
        expect(json_response["name"]).to eq ["can't be blank"]
      end
    end

    context "no authorization token" do
      it "renders unauthorized access error" do
        create_bucketlist(@user, @token, 10)
        bucketlist = Bucketlist.last

        post(
          "/api/v1/bucketlists/#{bucketlist.id}/items",
          name: "mynames"
        )
        json_response = JSON.parse(response.body)

        expect(json_response["error"]).to eq "unauthorized access"
        expect(response).to have_http_status(401)
      end
    end
  end
end
