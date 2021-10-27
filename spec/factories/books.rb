require 'faker'

FactoryBot.define do
  factory :book do
    Genre { Faker::Book.genre }
    Author { Faker::Book.author }
    Image { 'img.png' }
    Title { Faker::Book.title }
    Publisher { Faker::Book.publisher }
    Year { Faker::Number.number(digits: 4) }
  end
end
