# frozen_string_literal: true

require 'test_helper'

class CheckLinterJobTest < ActiveJob::TestCase
  test 'create check with valid js repo' do
    check = repository_checks(:one)

    CheckLinterJob.perform_now(check.id)

    check.reload
    assert { check.finished? }
    assert { check.passed == true }
    assert_not(check.errors_count)
  end

  test 'create check with valid ruby repo' do
    check = repository_checks(:three)

    CheckLinterJob.perform_now(check.id)

    check.reload
    assert { check.finished? }
    assert { check.passed == true }
    assert_not(check.errors_count)
  end
end
