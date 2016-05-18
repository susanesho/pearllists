require "rails_helper"
RSpec.describe "Create Bucketlist", type: :request do
  after(:all) do
    Bucketlist.destroy_all
  end

  describe "Post /bucketlists" do
    context "when creating a bucketlist with valid params" do
      it "creates a bucketlist" do
        bucketlist = create(:bucketlist)

        post(
          "/api/v1/bucketlists/",
          { name: "bucket1" },
          HTTP_AUTHORIZATION: set_login(bucketlist.user)
        )

        expect(response).to have_http_status(201)
        expect(json_response["bucketlist"]["name"]).to eq "bucket1"
        expect(json_response["bucketlist"]["created_by"]).to eq(
          bucketlist.user.id
        )
      end
    end

    context "when creating a bucketlist with invalid params" do
      it "renders error and does not create bucketlist" do
        bucketlist = create(:bucketlist)

        post(
          "/api/v1/bucketlists/",
          nil,
          HTTP_AUTHORIZATION: set_login(bucketlist.user)
        )

        expect(response).to have_http_status(400)
        expect(json_response["name"]).to eq ["can't be blank"]
      end
    end

    context "when no authorization token is passed" do
      it "renders unauthorized access error" do
        post(
          "/api/v1/bucketlists/",
          name: "bucket1"
        )

        expect(json_response["error"]).to eq "unauthorized access"
        expect(response).to have_http_status(401)
      end
    end
  end
end
