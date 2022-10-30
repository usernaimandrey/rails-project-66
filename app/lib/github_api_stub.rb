# frozen_string_literal: true

class GithubApiStub
  def initialize(*); end

  def fetch_repo(_github_id)
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

  def setup_hook(_github_id); end

  def fetch_links_github
    [['octocat/Hello-World'], [1_296_269]]
  end

  def fetch_last_commit_ref(_full_name)
    { last_commit_sha: '5fgrt', last_commit_url: 'https://github.com/commits/5fgrt' }
  end
end
