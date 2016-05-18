require "rails_helper"
RSpec.describe "No route found", type: :request do
  describe "get /*unmatched_route" do
    context "user requests an invalid route" do
      it "renders invalid address error message" do
        get("/*unmatched_route")

        expect(response).to have_http_status(404)
        expect(
          json_response["error"]
        ).to eq "Invalid address specify a valid endpoint!"
      end
    end
  end
end
