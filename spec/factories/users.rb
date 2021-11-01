require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'qwerty' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    image_url { 'https://image.png.com' }
  end
end
