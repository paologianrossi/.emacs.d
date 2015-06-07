FactoryGirl.define do
  factory :user do
    provider "facebook"
    uid "12345"
    first_name "John"
    last_name "Doe"
    name "John Doe"
    email "johndoe@example.com"
    image_url "http://example.com/picture/1"
    gender "male"
    link "http://social.example.com/12345/feed"
    locale "it_IT"
    significant_other_uid "54321"
  end
end
