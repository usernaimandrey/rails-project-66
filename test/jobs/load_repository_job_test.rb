# frozen_string_literal: true

require 'test_helper'

class LoadRepositoryJobTest < ActiveJob::TestCase
  test 'create repository' do
    github_response = load_fixture('files/response.json')
    user = users(:one)
    attr = {
      github_id: 1_296_269
    }
    repo = user.repositories.build(attr)
    repo.save

    assert_not(repo.name)
    LoadRepositoryJob.perform_now(repo.id, user.id)
    repo.reload
    assert { repo.name == JSON.parse(github_response)['name'] }
  end
end
