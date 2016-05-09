require "rails_helper"
RSpec.describe "Edit Items", type: :request do
  before(:all) do
    @user = create(:user)
    @token = set_login(@user)
  end

  after(:all) do
    User.destroy_all
    Bucketlist.destroy_all
  end

  describe "put /bucketlists/:id/items/:id" do
    context "when bucketlist items exists for user" do
      it "edits a single bucketlist item" do
        create_bucketlist(@user, @token, 1)
        create_item(@user, @token, 1)
        bucketlist = Bucketlist.last
        item = Item.last

        put(
          "/api/v1/bucketlists/#{bucketlist.id}/items/#{item.id}",
          { name: "buck" },
          HTTP_AUTHORIZATION: @token
        )

        json_response = JSON.parse(response.body)
        expect(json_response["item"]["name"]).to eq "buck"
        expect(response).to have_http_status(200)
      end
    end

    context "when updating with invalid parameters" do
      it "does not update item" do
        create_bucketlist(@user, @token, 1)
        create_item(@user, @token, 1)
        bucketlist = Bucketlist.last
        item = Item.last

        put(
          "/api/v1/bucketlists/#{bucketlist.id}/items/#{item.id}",
          { name: "" },
          HTTP_AUTHORIZATION: @token
        )
        json_response = JSON.parse(response.body)
        expect(json_response["name"]).to eq ["can't be blank"]
        expect(response).to have_http_status(400)
      end
    end

    context "when item does not exist for user" do
      it "renders error" do
        create_bucketlist(@user, @token, 1)
        create_item(@user, @token, 1)
        bucketlist = Bucketlist.last

        put(
          "/api/v1/bucketlists/#{bucketlist.id}/items/20000",
          { name: "buck" },
          HTTP_AUTHORIZATION: @token
        )

        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq "item does not exist"
        expect(response).to have_http_status(404)
      end
    end

    context "no authorization token" do
      it "renders unauthorized access error" do
        create_bucketlist(@user, @token, 1)
        create_item(@user, @token, 1)
        bucketlist = Bucketlist.last
        item = Item.last

        put(
          "/api/v1/bucketlists/#{bucketlist.id}/items/#{item.id}",
          name: "buck"
        )
        json_response = JSON.parse(response.body)

        expect(json_response["error"]).to eq "unauthorized access"
        expect(response).to have_http_status(401)
      end
    end
  end
end
