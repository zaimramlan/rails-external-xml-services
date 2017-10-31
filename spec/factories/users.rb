FactoryGirl.define do
  factory :user do
    title Faker::Name.prefix
    name  Faker::Name.name_with_middle
    email Faker::Internet.email
  end
end
