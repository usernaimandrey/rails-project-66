# frozen_string_literal: true

class FetchLastCommitRef
  class << self
    def fetch(token, repo_link)
      client = ApplicationContainer[:octokit].call(token)
      response = client.commits(repo_link).first
      { last_commit_sha: response[:sha][..5], last_commit_url: response[:html_url] }
    end
  end
end
