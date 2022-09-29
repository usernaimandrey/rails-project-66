# frozen_string_literal: true

class CreateRepositoryService
  class << self
    def call(link, user)
      client = Octokit::Client.new(access_token: user&.token, auto_paginate: true)
      response = client.repo(link)
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
