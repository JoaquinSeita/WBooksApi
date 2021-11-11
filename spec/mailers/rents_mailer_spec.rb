require 'rails_helper'

RSpec.describe RentsMailer, type: :mailer do
  include_context 'User, Book and Rent'

  let(:user_mail) { create(:user, email: 'juan@gmail.com') }
  let(:rent) { create(:rent, user_id: user_mail.id, book_id: book.id) }

  describe 'rent_confirmation' do
    let(:mail) { RentsMailer.rent_confirmation(rent) }

    it 'check the headers' do
      expect(mail.subject).to eq('[NO-REPLY] Details about the book rental!')
      expect(mail.from).to eq([Rails.application.credentials.mailer_username])
      expect(mail.to).to eq(['juan@gmail.com'])
    end

    it 'check the body' do
      expect(mail.body.encoded).to include rent.to.to_s
      expect(mail.body.encoded).to include rent.from.to_s
      expect(mail.body.encoded).to include Time.zone.today.to_s
      expect(mail.body.encoded).to include book.title.to_s
      expect(mail.body.encoded).to include book.author.to_s
    end

    it 'check email "en" traduction' do
      I18n.with_locale(user.locale) do
        expect(mail.body.encoded).to include 'Thank you!'
      end
    end
  end

  describe 'When user.locale = "es"' do
    let(:user_mail) { create(:user, email: 'juan@gmail.com', locale: 'es') }
    let(:rent) { create(:rent, user_id: user_mail.id, book_id: book.id) }
    let(:mail) { RentsMailer.rent_confirmation(rent) }

    it 'check email "es" traduction' do
      I18n.with_locale(user.locale) do
        expect(mail.body.encoded).to include '¡Muchas gracias!'
      end
    end
  end
end
