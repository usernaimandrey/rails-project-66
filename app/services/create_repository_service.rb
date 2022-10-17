# frozen_string_literal: true

class CreateRepositoryService
  class << self
    def call(link, user)
      api_path = Rails.application.routes.url_helpers.api_checks_path
      client = ApplicationContainer[:octokit].call(user.token)
      response = client.repo(link)
      client.create_hook(
        link,
        'web',
        { url: "#{ENV.fetch('BASE_URL', nil)}#{api_path}", content_type: 'json' },
        { events: %w[push], active: true }
      )

      attr = {
        link: link,
        clone_url: response[:clone_url],
        repo_name: response[:name],
        language: response[:language]&.downcase,
        repo_created_at: response[:created_at],
        repo_updated_at: response[:updated_at]
      }

      user.repositories.build(attr)
    rescue StandardError
      Repository.new
    end
  end
end
