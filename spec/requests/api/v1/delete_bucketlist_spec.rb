require "rails_helper"
RSpec.describe "Edit Bucketlist", type: :request do
  before(:all) do
    @user = create(:user)
    @token = set_login(@user)
  end

  after(:all) do
    User.destroy_all
    Bucketlist.destroy_all
  end

  describe "delete /bucketlists/:id" do
    context "when a user deletes a bucketlist" do
      it "deletes a single bucketlist" do
        create_bucketlist(@user, @token, 1)
        bucketlist = Bucketlist.last
        delete(
          "/api/v1/bucketlists/#{bucketlist.id}",
          nil,
          HTTP_AUTHORIZATION: @token
        )
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq "bucket have been destroyed"
        expect(Bucketlist.count).to eq 0
        expect(response).to have_http_status(200)
      end
    end

    context "when  bucketlist does not exist" do
      it "renders error" do
        create_bucketlist(@user, @token, 1)
        delete("/api/v1/bucketlists/2000", nil, HTTP_AUTHORIZATION: @token)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq "bucket was not destroyed"
        expect(Bucketlist.count).to eq 1
        expect(response).to have_http_status(403)
      end
    end
  end
end
