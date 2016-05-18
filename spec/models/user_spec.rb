require "rails_helper"

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe "Instance Methods" do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:generate_auth_token) }
  end

  describe "user validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe "secure password" do
    it { should have_secure_password }
  end

  describe "user associations" do
    it { should have_many(:bucketlists) }
  end
end
