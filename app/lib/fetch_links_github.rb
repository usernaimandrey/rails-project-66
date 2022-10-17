# frozen_string_literal: true

class FetchLinksGithub
  class << self
    def fetch(user)
      client = ApplicationContainer["octokit_#{user.id}".to_sym]
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
