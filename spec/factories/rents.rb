FactoryBot.define do
  factory :rent do
    user_id {}
    book_id {}
    from { '2021-10-27' }
    to { '2021-10-27' }
  end
end
