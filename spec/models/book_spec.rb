require 'rails_helper'

describe Book, type: :model do
    describe "#create" do
        let(:book) { create(:book) }

        context "When book is fully completed" do
            it { expect(book).to be_valid }
        end

        context "When Author is nil" do
            let(:Author) { nil }
            it { is_expected.to be_invalid }
        end

        context "When Title is nil" do
            let(:Title) { nil }
            it { is_expected.to be_invalid }
        end

        context "When year.length > 5 digits" do
            let(:Year) { 20000 } 
            it { is_expected.to be_invalid }
        end
    end
end

