require 'rails_helper'

RSpec.describe RentsMailer, type: :mailer do
  include_context 'User, Book and Rent'

  let(:user_mail) { create(:user, email: 'juan@gmail.com') }
  let(:rent) { create(:rent, user_id: user_mail.id, book_id: book.id) }

  describe 'rent_confirmation' do
    let(:mail) { RentsMailer.rent_confirmation(rent) }

    it 'check the headers' do
      expect(mail.subject).to eq('[NO-REPLY] Details about the book rental!')
      expect(mail.from).to eq([ENV['MAILER_USERNAME'].to_s])
      expect(mail.to).to eq(['juan@gmail.com'])
    end

    it 'check the body' do
      expect(mail.body.encoded).to include rent.to.to_s
      expect(mail.body.encoded).to include rent.from.to_s
      expect(mail.body.encoded).to include Time.zone.today.to_s
      expect(mail.body.encoded).to include book.title.to_s
      expect(mail.body.encoded).to include book.author.to_s
    end
  end
end
