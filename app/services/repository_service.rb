# frozen_string_literal: true

class RepositoryService
  class << self
    def call(link, user)
      response = Octokit::Client.new(access_token: user&.token).repo(link)

      attr = {
        link: link,
        repo_name: response[:name],
        language: response[:language],
        repo_created_at: response[:created_at],
        repo_updated_at: response[:updated_at]
      }

      user.repositories.build(attr)
    rescue StandardError
      Repository.new
    end
  end
end
