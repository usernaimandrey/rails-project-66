# frozen_string_literal: true

require 'test_helper'

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  test '#create' do
    repo = repositories(:no_check)
    attributes = {
      full_name: repo.full_name
    }
    post api_checks_path params: { repository: attributes }

    check = repo.checks.last

    assert { repo.id == check.repository_id }
    assert { check.finished? }
    assert { check.passed == true }
    assert_not(check.errors_count)
    assert_response 200
  end
end
