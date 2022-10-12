# frozen_string_literal: true

require 'test_helper'

class Web::Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @repo_valid = repositories(:repo_js_valid)
    @check_cheking = repository_checks(:one)
    sign_in @user
  end

  test '#show' do
    get repository_check_path(@repo_valid, @check_cheking)

    assert_response :success
  end

  test 'show with not auth' do
    delete session_path
    get repository_check_path(@repo_valid, @check_cheking)

    assert_redirected_to root_path default_url_options
  end

  test 'create check with valit js repo' do
    assert_difference '@repo_valid.checks.count' do
      post repository_checks_path(@repo_valid)
    end

    check = @repo_valid.checks.last

    assert_redirected_to @repo_valid
    assert { check.errors_count.nil? }
    assert { check.finishing? }
  end

  test 'create check with invalid js repo' do
    repo_invalid = repositories(:repo_js_invalid)
    checks_count = repo_invalid.checks.count

    post repository_checks_path(repo_invalid)

    check = repo_invalid.checks.last
    repo_invalid.reload
    assert_not(checks_count == repo_invalid.checks.count)
    assert_redirected_to repo_invalid
    assert_not(check.errors_count.nil?)
    assert { check.finishing? }
  end
end