require "rails_helper"
RSpec.describe "Get Bucketlist", type: :request do
  after(:all) do
    Bucketlist.destroy_all
  end

  describe "get /bucketlists" do
    context "when user has many bucketlists" do
      it "gets all bucketlists" do
        user = create(:user)
        create_list(:bucketlist, 10, user: user)

        get(
          "/api/v1/bucketlists",
          nil,
          HTTP_AUTHORIZATION: set_login(user)
        )

        expect(response).to have_http_status(200)
        expect(json_response["bucketlists"].count).to eq 10
      end
    end

    context "when user has no bucketlist" do
      it "renders error" do
        bucketlist = create(:bucketlist).destroy

        get(
          "/api/v1/bucketlists",
          nil,
          HTTP_AUTHORIZATION:
          set_login(bucketlist.user)
        )

        expect(response).to have_http_status(404)
        expect(json_response["error"]).to eq message.no_bucket_found
      end
    end
  end

  describe "get /bucketlists/:id" do
    context "when a specific bucketlist exist for user" do
      it "gets the specific bucketlist" do
        bucketlist = create(:bucketlist)

        get(
          "/api/v1/bucketlists/#{bucketlist.id}",
          nil,
          HTTP_AUTHORIZATION: set_login(bucketlist.user)
        )

        expect(response).to have_http_status(200)
        expect(json_response["bucketlist"]["name"]).to eq bucketlist.name
      end
    end

    context "when a specific bucketlist does not exist for user" do
      it "renders error" do
        bucketlist = create(:bucketlist)

        get(
          "/api/v1/bucketlists/2000",
          nil,
          HTTP_AUTHORIZATION:
          set_login(bucketlist.user)
        )

        expect(response).to have_http_status(404)
        expect(json_response["error"]).to eq message.no_bucket_found
      end
    end

    context "when no authorization token is passed" do
      it "renders unauthorized access error" do
        get("/api/v1/bucketlists", nil)

        expect(json_response["error"]).to eq message.unauthorized_access
        expect(response).to have_http_status(401)
      end
    end
  end
end
