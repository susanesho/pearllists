require "rails_helper"
RSpec.describe "Edit items", type: :request do
  after(:all) do
    Item.destroy_all
  end

  describe "put /bucketlists/:id/items/:id" do
    context "when a bucketlist item exists for user" do
      it "updates the item" do
        item = create(:item)

        put(
          "/api/v1/bucketlists/#{item.bucketlist.id}/items/#{item.id}",
          { name: "buck" },
          HTTP_AUTHORIZATION: set_login(item.bucketlist.user)
        )

        expect(json_response["item"]["name"]).to eq "buck"
        expect(response).to have_http_status(200)
      end
    end

    context "when updating with invalid params" do
      it "does not update item" do
        item = create(:item)

        put(
          "/api/v1/bucketlists/#{item.bucketlist.id}/items/#{item.id}",
          { name: "" },
          HTTP_AUTHORIZATION: set_login(item.bucketlist.user)
        )

        expect(json_response["name"][0]).to eq message.blank_field
        expect(response).to have_http_status(400)
      end
    end

    context "when item does not exist for user" do
      it "renders error" do
        item = create(:item)

        put(
          "/api/v1/bucketlists/#{item.bucketlist.id}/items/20000",
          { name: "buck" },
          HTTP_AUTHORIZATION: set_login(item.bucketlist.user)
        )

        expect(json_response["error"]).
          to eq message.update_message(item, "item")
        expect(response).to have_http_status(404)
      end
    end

    context "when no authorization token is passed" do
      it "renders unauthorized access error" do
        item = create(:item)

        put(
          "/api/v1/bucketlists/#{item.bucketlist.id}/items/#{item.id}",
          name: "buck"
        )

        expect(json_response["error"]).to eq message.unauthorized_access
        expect(response).to have_http_status(401)
      end
    end
  end
end
