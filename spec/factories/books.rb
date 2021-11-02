require 'faker'

FactoryBot.define do
  factory :book do
    genre { Faker::Book.genre }
    author { Faker::Book.author }
    image { 'img.png' }
    title { Faker::Book.title }
    publisher { Faker::Book.publisher }
    year { Faker::Number.between(from: 1300, to: 2021) }
    available { true }
  end
end
