class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.mailer_username
  layout 'mailer'
end
