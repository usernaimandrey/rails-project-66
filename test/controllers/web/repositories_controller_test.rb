# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  test '#index' do
    get repositories_path

    assert_response :success
  end

  test 'with not auth user' do
    delete session_path

    get repositories_path

    assert_redirected_to root_path default_url_options
  end

  test '#show' do
    repo = FactoryBot.create(:repository, user: @user)

    get repository_path(repo)

    assert_response :success
  end

  test '#new' do
    get new_repository_path

    assert_response :success
  end

  test 'new with not auth user' do
    delete session_path

    get new_repository_path

    assert_redirected_to root_path
  end

  test '#create' do
    attr = {
      github_id: 1_296_269
    }

    post repositories_path, params: { repository: attr }
    new_repo = Repository.find_by(attr)

    assert { new_repo }
    assert_redirected_to repositories_path default_url_options
    assert_enqueued_with job: CreateRepositoryJob
  end
end
