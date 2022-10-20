# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/check_linter_status_mailer
class CheckLinterStatusMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/check_linter_status_mailer/send_mail
  def send_mail
    CheckLinterStatusMailer.with(user: User.last, check: Repository::Check.last).send_mail
  end
end
