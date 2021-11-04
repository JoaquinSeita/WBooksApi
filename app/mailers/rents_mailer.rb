class RentsMailer < ApplicationMailer
  def rent_confirmation(rent)
    @rent = rent
    @book = Book.find(@rent.book_id)
    @user = User.find(@rent.user_id)
    @today = Time.zone.today

    mail to: @user.email.to_s, subject: '[NO-REPLY] Details about the book rental!'
  end
end
