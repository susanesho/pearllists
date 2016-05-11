require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe "instance method calls" do
    it { expect(user).to respond_to(:name) }
    it { expect(user).to respond_to(:email) }
    it { expect(user).to respond_to(:generate_auth_token) }
  end

  describe "creating a user" do
    context "when all parameters are present" do
      it "creates user" do
        name = Faker::Name.name
        email = Faker::Internet.email
        password = Faker::Internet.password(10, 20)
        user = User.new(name: name, email: email, password: password)
        expect(user).to be_valid
      end
    end

    context "when name is not present" do
      it "does not create user" do
        email = Faker::Internet.email
        password = Faker::Internet.password(10, 20)
        user = User.new(email: email, password: password)
        expect(user).to be_invalid
        expect(user.errors[:name]).to include "can't be blank"
      end
    end

    context "when email is not present" do
      it "does not create user" do
        name = Faker::Name.name
        password = Faker::Internet.password(10, 20)
        user = User.new(name: name, password: password)
        expect(user).to be_invalid
        expect(user.errors[:email]).to include "can't be blank"
      end
    end

    context "when email is not unique" do
      it "does not create user" do
        create(:user, email: "susan@gmail.com")
        user = build(:user, email: "susan@gmail.com")
        expect(user).to be_invalid
        expect(user.errors[:email]).to include "has already been taken"
        User.destroy_all
      end
    end
  end
end
