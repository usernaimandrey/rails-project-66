# frozen_string_literal: true

class UpdateRepositoryService
  class << self
    def call(repo_id)
      repo = Repository.find(repo_id)
      return unless repo

      github_api = ApplicationContainer[:github_api].call(repo.user, repo)

      response = github_api.fetch_repo
      github_api.setup_hook

      attr = {
        github_id: repo.github_id,
        full_name: response[:full_name],
        clone_url: response[:clone_url],
        name: response[:name],
        language: response[:language]&.downcase,
        default_branch: response[:default_branch],
        repo_created_at: response[:created_at],
        repo_updated_at: response[:updated_at]
      }

      repo.update(attr)
    rescue StandardError => e
      Rails.logger.debug e
    end
  end
end
