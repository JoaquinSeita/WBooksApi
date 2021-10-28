require 'rails_helper'

describe Rent, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:book) }

  %i[user_id book_id to from].each do |field|
    it { should validate_presence_of(field) }
  end

  before(:all) do
    @user1 = create(:user)
    @book1 = create(:book)
  end

  subject(:rent) do
    Rent.new(user_id: user_id, book_id: book_id, to: to, from: from)
  end

  let(:user_id) { @user1.id }
  let(:book_id) { @book1.id }
  let(:to) { Time.zone.today }
  let(:from) { Time.zone.today }

  it do
    is_expected.to be_valid
  end

  describe '#create' do
    %w[user_id book_id from to].each do |field|
      context "When #{field} is nil" do
        let(field.to_sym) { nil }
        it { is_expected.to be_invalid }
      end
    end
  end
end
