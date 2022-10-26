# frozen_string_literal: true

class GithubApiStub
  attr_reader :repo, :user, :clien

  def initialize(user, repo = nil)
    @repo = repo
    @user = user
  end

  def fetch_repo
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

  def setup_hook; end

  def fetch_links_github
    [['octocat/Hello-World'], [1_296_269]]
  end

  def fetch_last_commit_ref
    { last_commit_sha: '5fgrt', last_commit_url: 'https://github.com/commits/5fgrt' }
  end
end
