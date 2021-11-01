FactoryBot.define do
  factory :user do
    email { 'rama@mail.com' }
    password { 'qwerty' }
    first_name { 'Ramiro' }
    last_name { 'Pedraza' }
    image_url { 'image.png' }
  end
end
