# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
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

  test '#create' do
    github_response = load_fixture('files/response.json')
    owner = 'users'
    repo = 'octocat'
    api = 'https://api.github.com/repos'
    attr = {
      link: "#{owner}/#{repo}"
    }

    stub_request(:get, "#{api}/#{owner}/#{repo}")
      .to_return(
        headers: { 'Content-Type': 'application/json' },
        status: 200,
        body: github_response
      )

    post repositories_path, params: { repository: attr }
    new_repo = Repository.find_by(link: attr[:link])

    assert { new_repo }
    assert { new_repo.repo_name == JSON.parse(github_response)['name'] }
    assert_redirected_to repositories_path default_url_options
  end
end
