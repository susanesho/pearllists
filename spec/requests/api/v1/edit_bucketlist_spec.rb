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

  describe "put /bucketlists/:id" do
    context "when bucketlist exists for user" do
      it "edits a single bucketlist" do
        create_bucketlist(@user, @token, 1)
        bucketlist = Bucketlist.last
        put(
          "/api/v1/bucketlists/#{bucketlist.id}",
          { name: "bucket3" },
          HTTP_AUTHORIZATION: @token
        )
        json_response = JSON.parse(response.body)
        expect(json_response["bucketlist"]["name"]).to eq "bucket3"
        expect(response).to have_http_status(201)
      end
    end

    context "when the bucketlist does not exist for logged in user" do
      it "edits a single bucketlist" do
        create_bucketlist(@user, @token, 1)
        put(
          "/api/v1/bucketlists/2000",
          { name: "bucket3" },
          HTTP_AUTHORIZATION: @token
        )
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq "could not update bucketlist"
        expect(response).to have_http_status(403)
      end
    end
  end
end
