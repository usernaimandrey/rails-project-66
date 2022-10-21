# frozen_string_literal: true

require 'test_helper'

class CreateRepositoryJobTest < ActiveJob::TestCase
  test 'create repository' do
    github_response = load_fixture('files/response.json')
    user = users(:one)
    repo_id = 1_296_269
    api = 'https://api.github.com/repositories'
    attr = {
      github_id: repo_id
    }
    repo = user.repositories.build(attr)
    repo.save
    stub_request(:get, "#{api}/#{repo_id}")
      .to_return(
        headers: { 'Content-Type': 'application/json' },
        status: 200,
        body: github_response
      )
    stub_request(:post, "#{api}/#{repo_id}/hooks")

    assert_not(repo.name)
    CreateRepositoryJob.perform_now(repo.id, user.id)
    repo.reload
    assert { repo.name == JSON.parse(github_response)['name'] }
  end
end
