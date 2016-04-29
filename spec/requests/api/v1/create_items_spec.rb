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

        expect(response).to have_http_status(200)
        expect(json_response["item"]["name"]).to eq "mynames"
      end
    end

    context "when a user creates an item without a name" do
      it "renders error" do
        create_bucketlist(@user, @token, 1)
        bucketlist = Bucketlist.last

        post(
          "/api/v1/bucketlists/#{bucketlist.id}/items",
          { name: "" },
          HTTP_AUTHORIZATION: @token
        )
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(422)
        expect(json_response["name"]).to eq ["can't be blank"]
      end
    end

    context "when a bucketlist id does not exist or belong to user" do
      it "renders error" do
        create_bucketlist(@user, @token, 1)
        bucketlist = Bucketlist.last
        post(
          "/api/v1/bucketlists/#{bucketlist.id}/items",
          nil,
          HTTP_AUTHORIZATION: @token
        )
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(422)
        expect(json_response["name"]).to eq ["can't be blank"]
      end
    end
  end
end
