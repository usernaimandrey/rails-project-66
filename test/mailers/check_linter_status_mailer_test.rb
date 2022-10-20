# frozen_string_literal: true

require 'test_helper'

class CheckLinterStatusMailerTest < ActionMailer::TestCase
  test 'send_mail' do
    user = users(:one)
    check = repository_checks(:one)
    mail = CheckLinterStatusMailer.with(user: user, check: check).send_mail

    assert { user.email == mail.to.first }
  end
end
