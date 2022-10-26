# frozen_string_literal: true

require 'test_helper'

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  test '#create' do
    repo = repositories(:repo_js_valid)
    attributes = {
      full_name: repo.full_name
    }

    assert_difference 'repo.checks.count' do
      post api_checks_path params: { repository: attributes }
    end

    check = repo.checks.last

    assert { check.finished? }
    assert { check.passed == true }
    assert_not(check.errors_count)
    assert_response 200
  end
end
