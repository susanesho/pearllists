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
        expect(response).to have_http_status(201)
      end

      context "when item does not exists for user" do
        it "cannot edits an item not created or found" do
          create_bucketlist(@user, @token, 1)
          create_item(@user, @token, 1)
          bucketlist = Bucketlist.last

          put(
            "/api/v1/bucketlists/#{bucketlist.id}/items/20000",
            { name: "buck" },
            HTTP_AUTHORIZATION: @token
          )

          json_response = JSON.parse(response.body)
          expect(json_response["error"]).to eq "cannot update item"
          expect(response).to have_http_status(403)
        end
      end
    end
  end
end
