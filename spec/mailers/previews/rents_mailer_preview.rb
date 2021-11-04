# Preview all emails at http://localhost:3000/rails/mailers/rents_mailer
class RentsMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/rents_mailer/rent_confirmation
  def rent_confirmation
    RentsMailer.rent_confirmation
  end
end
