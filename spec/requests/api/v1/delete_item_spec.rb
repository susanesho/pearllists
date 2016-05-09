require "rails_helper"
RSpec.describe "Delete Item", type: :request do
  before(:all) do
    @user = create(:user)
    @token = set_login(@user)
  end

  after(:all) do
    User.destroy_all
    Bucketlist.destroy_all
  end

  describe "destroy /bucketlists/:id/items/:id" do
    context "when item exists" do
      it "destroys the item" do
        create_bucketlist(@user, @token, 1)
        create_item(@user, @token, 1)
        bucketlist = Bucketlist.last
        item = Item.last

        delete(
          "/api/v1/bucketlists/#{bucketlist.id}/items/#{item.id}",
          { name: "buck" },
          HTTP_AUTHORIZATION: @token
        )

        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq "item destroyed"
        expect(response).to have_http_status(200)
      end

      context "when item does not belong to user" do
        it "renders error and does not destroy item" do
          create_bucketlist(@user, @token, 1)
          create_item(@user, @token, 1)
          item = Item.last

          delete(
            "/api/v1/bucketlists/2000/items/#{item.id}",
            { name: "buck" },
            HTTP_AUTHORIZATION: @token
          )

          json_response = JSON.parse(response.body)
          expect(json_response["error"]).to eq "Unauthorized"
          expect(response).to have_http_status(403)
        end
      end

      context "when item does not exist" do
        it "renders error" do
          create_bucketlist(@user, @token, 1)
          create_item(@user, @token, 1)
          bucketlist = Bucketlist.last

          delete(
            "/api/v1/bucketlists/#{bucketlist.id}/items/20000",
            { name: "buck" },
            HTTP_AUTHORIZATION: @token
          )

          json_response = JSON.parse(response.body)
          expect(json_response["error"]).to eq "item was not destroyed"
          expect(response).to have_http_status(400)
        end
      end
    end
  end
end
