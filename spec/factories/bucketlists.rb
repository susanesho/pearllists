FactoryGirl.define do
  factory :bucketlist do
    name { Faker::Name.name }
    user
  end
end
