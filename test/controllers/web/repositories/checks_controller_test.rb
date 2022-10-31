# frozen_string_literal: true

require 'test_helper'

class Web::Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @repo = repositories(:one)
    @check = repository_checks(:one)
    sign_in @user
  end

  test '#show' do
    get repository_check_path(@repo, @check)

    assert_response :success
  end

  test 'show with not auth' do
    delete session_path
    get repository_check_path(@repo, @check)

    assert_redirected_to root_path default_url_options
  end

  test '#create' do
    repo = repositories(:no_check)
    post repository_checks_path(repo)

    check = repo.checks.last

    assert_redirected_to repo
    assert { check.finished? }
    assert { check.passed == true }
    assert { check.count_errors.nil? }
  end
end
