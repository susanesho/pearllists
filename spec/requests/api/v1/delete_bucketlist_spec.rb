require "rails_helper"
RSpec.describe "Delete Bucketlist", type: :request do
  after(:all) do
    Bucketlist.destroy_all
  end

  describe "delete /bucketlists/:id" do
    context "when bucketlist exists" do
      it "deletes the bucketlist" do
        bucketlist = create(:bucketlist)

        delete(
          "/api/v1/bucketlists/#{bucketlist.id}",
          nil,
          HTTP_AUTHORIZATION: set_login(bucketlist.user)
        )

        expect(json_response["message"]).
          to eq message.delete_success_message(bucketlist, "bucket")
        expect(Bucketlist.count).to eq 0
        expect(response).to have_http_status(200)
      end
    end

    context "when bucketlist does not exist" do
      it "renders error" do
        bucketlist = create(:bucketlist)

        delete(
          "/api/v1/bucketlists/2000",
          nil,
          HTTP_AUTHORIZATION:
          set_login(bucketlist.user)
        )

        expect(json_response["error"]).
          to eq message.delete_error_message(bucketlist, "bucket")
        expect(Bucketlist.count).to eq 1
        expect(response).to have_http_status(404)
      end
    end

    context "when no authorization token is passed" do
      it "renders unauthorized access error" do
        bucketlist = create(:bucketlist)

        delete(
          "/api/v1/bucketlists/#{bucketlist.id}",
          nil
        )

        expect(json_response["error"]).to eq message.unauthorized_access
        expect(response).to have_http_status(401)
      end
    end
  end
end
