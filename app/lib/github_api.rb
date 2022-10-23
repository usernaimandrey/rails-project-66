# frozen_string_literal: true

class GithubApi
  class << self
    def call(user, repo)
      api_path = Rails.application.routes.url_helpers.api_checks_path
      url = "#{ENV.fetch('BASE_URL', nil)}#{api_path}"
      client = ApplicationContainer[:octokit].call(user.token)

      response = client.repo(repo.github_id)
      client.hooks(repo.github_id).each do |hook|
        if hook[:config][:url] == url
          client.remove_hook(repo.github_id, hook[:id])
        end
      end

      client.create_hook(
        repo.github_id,
        'web',
        { url: url, content_type: 'json' },
        { events: %w[push], active: true }
      )
      response
    end
  end
end
