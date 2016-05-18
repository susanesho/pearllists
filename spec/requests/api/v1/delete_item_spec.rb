require "rails_helper"
RSpec.describe "Delete Item", type: :request do
  after(:all) do
    Item.destroy_all
  end

  describe "destroy /bucketlists/:id/items/:id" do
    context "when item exists for the bucketlist" do
      it "destroys the item" do
        item = create(:item)

        delete(
          "/api/v1/bucketlists/#{item.bucketlist.id}/items/#{item.id}", {},
          HTTP_AUTHORIZATION: set_login(item.bucketlist.user)
        )

        expect(json_response["message"]).to eq "item destroyed"
        expect(response).to have_http_status(200)
      end
    end

    context "when item does not belong to the bucketlist" do
      it "renders error and does not destroy item" do
        item = create(:item)

        delete(
          "/api/v1/bucketlists/2000/items/#{item.id}",
          { name: "buck" },
          HTTP_AUTHORIZATION: set_login(item.bucketlist.user)
        )

        expect(json_response["error"]).to eq "Unauthorized"
        expect(response).to have_http_status(403)
      end
    end

    context "when item does not exist" do
      it "renders error" do
        item = create(:item)

        delete(
          "/api/v1/bucketlists/#{item.bucketlist.id}/items/20000",
          { name: "buck" },
          HTTP_AUTHORIZATION: set_login(item.bucketlist.user)
        )

        expect(json_response["error"]).to eq "item was not destroyed"
        expect(response).to have_http_status(404)
      end
    end

    context "when no authorization token is passed" do
      it "renders unauthorized access error" do
        item = create(:item)

        delete(
          "/api/v1/bucketlists/#{item.bucketlist.id}/items/#{item.id}",
        )

        expect(json_response["error"]).to eq "unauthorized access"
        expect(response).to have_http_status(401)
      end
    end
  end
end
