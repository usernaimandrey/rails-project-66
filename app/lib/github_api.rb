# frozen_string_literal: true

class GithubApi
  class << self
    def get_repo(user, repo)
      client = ApplicationContainer[:octokit].call(user.token)
      client.repo(repo.github_id)
    end

    def setup_hook(repo)
      client = ApplicationContainer[:octokit].call(repo.user.token)
      url = Rails.application.routes.url_helpers.api_checks_url
      client.hooks(repo.github_id).each do |hook|
        if hook[:config][:url] == url
          client.remove_hook(github_id, hook[:id])
        end
      end

      client.create_hook(
        repo.github_id,
        'web',
        { url: url, content_type: 'json' },
        { events: %w[push], active: true }
      )
    end

    def fetch_links_github(user)
      client = ApplicationContainer[:octokit].call(user.token)
      language = Repository.language.values
      client
        .repos
        .filter { |repo| language.include?(repo[:language]&.downcase) }
        .map { |repo| [repo[:full_name], repo[:id]] }
    rescue StandardError
      []
    end

    def fetch_last_commit_ref(token, full_name)
      client = ApplicationContainer[:octokit].call(token)
      response = client.commits(full_name).first
      { last_commit_sha: response[:sha][0..6], last_commit_url: response[:html_url] }
    end
  end
end
