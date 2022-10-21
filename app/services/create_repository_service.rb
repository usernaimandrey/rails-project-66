# frozen_string_literal: true

class CreateRepositoryService
  class << self
    def call(repo_id, user_id)
      user = User.find_by(id: user_id)
      repo = user.repositories.find_by(id: repo_id)
      response = ApplicationContainer[:github_api].call(user, repo)

      attr = {
        github_id: repo.github_id,
        full_name: response[:full_name],
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
