require "rails_helper"
RSpec.describe "Delete Bucketlist", type: :request do
  before(:all) do
    @user = create(:user)
    @token = set_login(@user)
  end

  after(:all) do
    User.destroy_all
    Bucketlist.destroy_all
  end

  describe "delete /bucketlists/:id" do
    context "when bucketlist exists" do
      it "deletes the bucketlist" do
        bucketlist = create(:bucketlist, user: @user)
        delete(
          "/api/v1/bucketlists/#{bucketlist.id}",
          nil,
          HTTP_AUTHORIZATION: @token
        )
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq "bucket destroyed"
        expect(Bucketlist.count).to eq 0
        expect(response).to have_http_status(200)
      end
    end

    context "when bucketlist does not exist" do
      it "renders error" do
        bucketlist = create(:bucketlist, user: @user)
        delete("/api/v1/bucketlists/2000", nil, HTTP_AUTHORIZATION: @token)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq "bucket was not destroyed"
        expect(Bucketlist.count).to eq 1
        expect(response).to have_http_status(404)
      end
    end

    context "when no authorization token is passed" do
      it "renders unauthorized access error" do
        bucketlist = create(:bucketlist, user: @user)
        delete(
          "/api/v1/bucketlists/#{bucketlist.id}",
          nil
        )
        json_response = JSON.parse(response.body)

        expect(json_response["error"]).to eq "unauthorized access"
        expect(response).to have_http_status(401)
      end
    end
  end
end
