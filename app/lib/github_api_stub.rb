# frozen_string_literal: true

class GithubApiStub
  class << self
    def call(_user, _repo)
      {
        github_id: 1_296_269,
        full_name: 'octocat/Hello-World',
        clone_url: 'https://github.com/octocat/Hello-World.git',
        name: 'Hello-World',
        language: 'javascript',
        repo_created_at: 10.days.ago,
        repo_updated_at: 5.days.ago
      }
    end
  end
end
