# frozen_string_literal: true

class CreateRepositoryService
  class << self
    def call(repo_id)
      repo = Repository.find(repo_id)
      user = repo.user
      github_api = ApplicationContainer[:github_api]
      response = github_api.get_repo(user, repo)
      github_api.setup_hook(repo)

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
