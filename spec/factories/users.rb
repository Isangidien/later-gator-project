FactoryGirl.define do

  pw = Faker::Internet.password
  factory :user do
    username Faker::Name.first_name
    email Faker::Internet.email
    password pw
    password_confirmation pw
    confirmed_at Time.now
  end
end
