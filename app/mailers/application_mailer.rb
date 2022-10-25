# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAIL_USERNAME', 'example@mail.com')
  layout 'mailer'
end
