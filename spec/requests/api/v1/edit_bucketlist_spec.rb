require "rails_helper"
RSpec.describe "Edit Bucketlist", type: :request do
  after(:all) do
    Bucketlist.destroy_all
  end

  describe "put /bucketlists/:id" do
    context "when bucketlist exists" do
      it "updates bucketlist" do
        bucketlist = create(:bucketlist)

        put(
          "/api/v1/bucketlists/#{bucketlist.id}",
          { name: "bucket3" },
          HTTP_AUTHORIZATION: set_login(bucketlist.user)
        )

        expect(json_response["bucketlist"]["name"]).to eq "bucket3"
        expect(response).to have_http_status(200)
      end
    end

    context "when updating with invalid params" do
      it "does not update bucketlist" do
        bucketlist = create(:bucketlist)

        put(
          "/api/v1/bucketlists/#{bucketlist.id}",
          { name: "" },
          HTTP_AUTHORIZATION:  set_login(bucketlist.user)
        )

        expect(json_response["name"]).to eq ["can't be blank"]
        expect(response).to have_http_status(400)
      end
    end

    context "when the bucketlist does not exist" do
      it "renders error and does not update bucketlist" do
        bucketlist = create(:bucketlist)

        put(
          "/api/v1/bucketlists/2000",
          { name: "bucket3" },
          HTTP_AUTHORIZATION:  set_login(bucketlist.user)
        )

        expect(json_response["error"]).to eq "bucket does not exist"
        expect(response).to have_http_status(404)
      end
    end

    context "when no authorization token is passed" do
      it "renders unauthorized access error" do
        bucketlist = create(:bucketlist)

        put(
          "/api/v1/bucketlists/#{bucketlist.id}",
          name: "bucket3"
        )

        expect(json_response["error"]).to eq "unauthorized access"
        expect(response).to have_http_status(401)
      end
    end
  end
end
