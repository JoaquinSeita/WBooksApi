FactoryBot.define do
  factory :user do
    email { 'rama@mail.com' }
    password { 'qwerty' }
    first_name { 'Ramiro' }
    last_name { 'Pedraza' }
  end
end
