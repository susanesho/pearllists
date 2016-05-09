require "rails_helper"
RSpec.describe "Search Bucketlist", type: :request do
  before(:all) do
    @user = create(:user)
    @token = set_login(@user)
  end

  after(:all) do
    User.destroy_all
    Bucketlist.destroy_all
  end

  describe "Post /bucketlist" do
    context "search params" do
      it "gets search result" do
        create_bucketlist(@user, @token, 5)

        get(
          "/api/v1/bucketlists/?q=",
          nil,
          HTTP_AUTHORIZATION: @token
        )
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_response["bucketlists"].length).to eq 5
      end
    end

    context "paginated request" do
      it "returns user specified results" do
        create_bucketlist(@user, @token, 10)

        get(
          "/api/v1/bucketlists?page=1&limit=2",
          nil,
          HTTP_AUTHORIZATION: @token
        )
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_response["bucketlists"].length).to eq 2
      end
    end

    context "no authorization token" do
      it "renders unauthorized access error" do
        create_bucketlist(@user, @token, 5)

        get(
          "/api/v1/bucketlists/?q=",
          nil,
        )
        json_response = JSON.parse(response.body)

        expect(json_response["error"]).to eq "unauthorized access"
        expect(response).to have_http_status(401)
      end
    end
  end
end
