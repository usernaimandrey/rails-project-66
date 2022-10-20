# frozen_string_literal: true

require 'test_helper'

class CheckLinterJobTest < ActiveJob::TestCase
  test 'create check with valid js repo' do
    repo_valid = repositories(:repo_js_valid)
    check = repository_checks(:one)

    CheckLinterJob.perform_now(repo_valid.id, check.id)

    check.reload
    assert { check.finishing? }
    assert { check.passed == true }
    assert_not(check.errors_count)
  end

  test 'create check with invalid js repo' do
    repo_invalid = repositories(:repo_js_invalid)
    check = repository_checks(:two)

    CheckLinterJob.perform_now(repo_invalid.id, check.id)

    check.reload
    assert { check.finishing? }
    assert { check.passed == false }
    assert { check.errors_count }
  end

  test 'create check with valid ruby repo' do
    repo_valid = repositories(:repo_rb_valid)

    check = repository_checks(:three)

    CheckLinterJob.perform_now(repo_valid.id, check.id)

    check.reload
    assert { check.finishing? }
    assert { check.passed == true }
    assert_not(check.errors_count)
  end

  test 'create check with invalid ruby repo' do
    repo_invalid = repositories(:repo_rb_invalid)

    check = repository_checks(:four)

    CheckLinterJob.perform_now(repo_invalid.id, check.id)

    check.reload
    assert { check.finishing? }
    assert { check.passed == false }
    assert { check.errors_count }
  end
end
