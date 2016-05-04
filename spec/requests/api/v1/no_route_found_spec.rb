require "rails_helper"
RSpec.describe "No route found", type: :request do
  describe "get /*unmatched_route" do
    context "user enters an invalid address" do
      it "gets a route that does not exist" do
        get("/*unmatched_route")
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(404)
        expect(
          json_response["error"]
        ).to eq "Invalid address specify a valid endpoint!"
      end
    end
  end
end
