require 'rails_helper'

describe Book, type: :model do
  %i[Genre Author Image Title Publisher Year].each do |field|
    it { should validate_presence_of(field) }
  end

  before(:all) do
    @book = create(:book)
  end

  subject(:book) do
    Book.new(Genre: genre, Author: author, Image: image, Title: title, Publisher: publisher,
             Year: year)
  end

  let(:genre) { @book.Genre }
  let(:author) { @book.Author }
  let(:image) { @book.Image }
  let(:title) { @book.Title }
  let(:publisher) { @book.Publisher }
  let(:year) { @book.Year }

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
