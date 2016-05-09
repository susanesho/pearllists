require "rails_helper"
RSpec.describe "Get Bucketlist", type: :request do
  before(:all) do
    @user = create(:user)
    @token = set_login(@user)
  end

  after(:all) do
    User.destroy_all
    Bucketlist.destroy_all
  end

  describe "get /bucketlists" do
    context "when user has bucketlists" do
      it "gets all bucketlists" do
        create_bucketlist(@user, @token, 10)
        get("/api/v1/bucketlists", nil, HTTP_AUTHORIZATION: @token)
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_response["bucketlists"].count).to eq 10
      end
    end

    context "when user has no bucketlist" do
      it "renders error" do
        Bucketlist.destroy_all
        get("/api/v1/bucketlists", nil, HTTP_AUTHORIZATION: @token)
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(404)
        expect(json_response["error"]).to eq "no buckets found"
      end
    end
  end

  describe "get /bucketlists/:id" do
    context "when bucketlist exist" do
      it "gets a single bucketlist" do
        create_bucketlist(@user, @token, 1)
        bucketlist = Bucketlist.last
        get(
          "/api/v1/bucketlists/#{bucketlist.id}",
          nil,
          HTTP_AUTHORIZATION: @token
        )

        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_response["bucketlist"]["name"]).to eq bucketlist.name
      end
    end

    context "when bucketlist does not exist" do
      it "renders error" do
        create_bucketlist(@user, @token, 1)
        get("/api/v1/bucketlists/2000", nil, HTTP_AUTHORIZATION: @token)
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(404)
        expect(json_response["error"]).to eq "no bucket found"
      end
    end

    context "no authorization token" do
      it "renders unauthorized access error" do
        create_bucketlist(@user, @token, 10)
        get("/api/v1/bucketlists", nil)
        json_response = JSON.parse(response.body)

        expect(json_response["error"]).to eq "unauthorized access"
        expect(response).to have_http_status(401)
      end
    end
  end
end
