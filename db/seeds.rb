# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
100.times do
    Book.create(
    genre: Faker::Book.genre,
    author: Faker::Book.author,
    image: 'img.png',
    title: Faker::Book.title,
    publisher: Faker::Book.publisher,
    year: Faker::Number.between(from: 1300, to:2021 )
    )
end
