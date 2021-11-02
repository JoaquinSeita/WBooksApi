RSpec.shared_context 'User, Book and Rent' do
  let!(:user) { create(:user) }
  let!(:book) { create(:book) }
  let!(:rent) { create(:rent, user_id: user.id, book_id: book.id) }
end
