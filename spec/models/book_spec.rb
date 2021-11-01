require 'rails_helper'

describe Book, type: :model do
  %i[genre author image title publisher year].each do |field|
    it { should validate_presence_of(field) }
  end

  before(:all) do
    @book = create(:book)
  end

  subject(:book) do
    Book.new(genre: genre, author: author, image: image, title: title, publisher: publisher,
             year: year)
  end

  let(:genre) { @book.genre }
  let(:author) { @book.author }
  let(:image) { @book.image }
  let(:title) { @book.title }
  let(:publisher) { @book.publisher }
  let(:year) { @book.year }

  it do
    is_expected.to be_valid
  end

  describe '#create' do
    %w[genre author image title publisher year].each do |field|
      context "When #{field} is nil" do
        let(field.to_sym) { nil }
        it { is_expected.to be_invalid }
      end
    end

    context 'When year.length > 5 digits' do
      let(:year) { 20_000 }
      it { is_expected.to be_invalid }
    end
  end
end
