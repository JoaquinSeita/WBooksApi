class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.mailer_username
  layout 'mailer'
end
