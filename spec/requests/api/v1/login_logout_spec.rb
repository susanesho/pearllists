require "rails_helper"
RSpec.describe "Login/Logout Users", type: :request do
  before(:all) do
    @user = create(:user)
    @token = set_login(@user)
  end

  after(:all) do
    User.destroy_all
    Bucketlist.destroy_all
  end

  describe "get /auth/login" do
    context "logging in with valid credentials" do
      it "logs user in" do
        post("/api/v1/auth/login", email: @user.email, password: @user.password)
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_response["message"]).to eq "logged in successfully"
      end
    end

    context "logging in without credentials" do
      it "renders error" do
        post("/api/v1/auth/login")
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(403)
        expect(json_response["error"]).to eq "user not found"
      end
    end
  end

  describe "get /auth/logout" do
    context "logging out a user" do
      it "logs a user out" do
        get("/api/v1/auth/logout", nil, HTTP_AUTHORIZATION: @token)
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_response["message"]).to eq "logged out successfully"
      end
    end
    context "logging out a user without a token" do
      it "logs a user out without a token" do
        get("/api/v1/auth/logout")
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_response["error"]).to eq "unauthorized access"
      end
    end
  end
end
