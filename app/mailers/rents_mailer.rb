class RentsMailer < ApplicationMailer
  default 'Content-Transfer-Encoding' => '7bit'

  def rent_confirmation(rent)
    @rent = rent
    @book = Book.find(@rent.book_id)
    @user = User.find(@rent.user_id)
    @today = Time.zone.today

    I18n.with_locale(@user.locale) do
      mail to: @user.email.to_s, subject: I18n.t('mail.confirmation.subject')
    end
  end
end
