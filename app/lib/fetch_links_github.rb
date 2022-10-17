# frozen_string_literal: true

class FetchLinksGithub
  class << self
    def fetch(user)
      client = ApplicationContainer[:octokit].call(user.token)
      language = %w[javascript ruby]
      client
        .repos
        .filter { |repo| language.include?(repo[:language]&.downcase) }
        .map(&:full_name)
    rescue StandardError
      []
    end
  end
end
