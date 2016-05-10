require "rails_helper"

RSpec.describe Bucketlist, type: :model do
  let(:bucketlist) { Bucketlist.new }

  describe "instance method calls" do
    it { expect(bucketlist).to respond_to(:name) }
    it { expect(bucketlist).to respond_to(:id) }
    it { expect(bucketlist).to respond_to(:user_id) }
  end

  describe "creating items" do
    context "when name is present" do
      it "creates bucketlist" do
        name = "soyamilk"
        bucketlist = Bucketlist.new(name: name)
        expect(bucketlist).to be_valid
      end
    end

     context "when name is not present" do
      it "does not create bucketlist" do
        name = ""
        bucketlist = Bucketlist.new(name: name)
        expect(bucketlist).to be_invalid
        expect(bucketlist.errors[:name]).to include "can't be blank"
      end
    end
  end
end
