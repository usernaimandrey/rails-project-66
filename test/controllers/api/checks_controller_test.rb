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

    assert_response 200
    assert_enqueued_with job: CheckLinterJob
  end
end
