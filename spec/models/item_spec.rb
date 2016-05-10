require "rails_helper"

RSpec.describe Item, type: :model do
  let(:item) { Item.new }

  describe "instance method calls" do
    it { expect(item).to respond_to(:name) }
    it { expect(item).to respond_to(:done) }
    it { expect(item).to respond_to(:bucketlist_id) }
  end

  describe "creating items" do
    context "when name is present" do
      it "creates item" do
        name = "soyamilk"
        item = Item.new(name: name)
        expect(item).to be_valid
      end
    end

    context "when name is not present" do
      it "does not create item" do
        name = ""
        item = Item.new(name: name)
        expect(item).to be_invalid
        expect(item.errors[:name]).to include "can't be blank"
      end
    end
  end
end
