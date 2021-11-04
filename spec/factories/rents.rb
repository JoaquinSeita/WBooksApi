require 'faker'

FactoryBot.define do
  factory :rent do
    user_id {}
    book_id {}
    from {  Time.zone.today }
    to { Time.zone.today + 1 }
  end
end
