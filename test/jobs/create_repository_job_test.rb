# frozen_string_literal: true

require 'test_helper'

class CreateRepositoryJobTest < ActiveJob::TestCase
  test 'create repository' do
    github_response = load_fixture('files/response.json')
    user = users(:one)
    owner = 'users'
    repo_name = 'octocat'
    api = 'https://api.github.com/repos'
    attr = {
      link: "#{owner}/#{repo_name}"
    }
    repo = user.repositories.build(attr)
    repo.save
    stub_request(:get, "#{api}/#{owner}/#{repo_name}")
      .to_return(
        headers: { 'Content-Type': 'application/json' },
        status: 200,
        body: github_response
      )
    stub_request(:post, "#{api}/#{owner}/#{repo_name}/hooks")

    assert_not(repo.repo_name)
    CreateRepositoryJob.perform_now(repo.id, user.id)
    repo.reload
    assert { repo.repo_name == JSON.parse(github_response)['name'] }
  end
end
