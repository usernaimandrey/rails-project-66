# frozen_string_literal: true

class CreateRepositoryService
  class << self
    def call(repo_id, user_id)
      user = User.find_by(id: user_id)
      repo = user.repositories.find_by(id: repo_id)
      api_path = Rails.application.routes.url_helpers.api_checks_path
      client = ApplicationContainer[:octokit].call(user.token)
      response = client.repo(repo.full_name)
      client.create_hook(
        repo.full_name,
        'web',
        { url: "#{ENV.fetch('BASE_URL', nil)}#{api_path}", content_type: 'json' },
        { events: %w[push], active: true }
      )

      attr = {
        full_name: repo.full_name,
        clone_url: response[:clone_url],
        name: response[:name],
        language: response[:language]&.downcase,
        repo_created_at: response[:created_at],
        repo_updated_at: response[:updated_at]
      }

      repo.update(attr)
    rescue StandardError
      Repository.new
    end
  end
end
