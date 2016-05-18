require "rails_helper"
RSpec.describe "Create Items", type: :request do
  after(:all) do
    Item.destroy_all
  end

  describe "Post /items" do
    context "when creating an item with valid params" do
      it "creates an item" do
        item = create(:item)

        post(
          "/api/v1/bucketlists/#{item.bucketlist.id}/items",
          { name: "mynames" },
          HTTP_AUTHORIZATION: set_login(item.bucketlist.user)
        )

        expect(response).to have_http_status(201)
        expect(json_response["item"]["name"]).to eq "mynames"
      end
    end

    context "when creating an item with invalid params" do
      it "renders error and does not create item" do
        item = create(:item)

        post(
          "/api/v1/bucketlists/#{item.bucketlist.id}/items",
          { name: "" },
          HTTP_AUTHORIZATION: set_login(item.bucketlist.user)
        )

        expect(response).to have_http_status(400)
        expect(json_response["name"]).to eq ["can't be blank"]
      end
    end

    context "when no authorization token is passed" do
      it "renders unauthorized access error" do
        item = create(:item)

        post(
          "/api/v1/bucketlists/#{item.bucketlist.id}/items",
          name: "mynames"
        )

        expect(json_response["error"]).to eq "unauthorized access"
        expect(response).to have_http_status(401)
      end
    end
  end
end
