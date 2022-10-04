# frozen_string_literal: true

class FetchLinksGithub
  class << self
    def fetch(user)
      client = ApplicationContainer["octokit_#{user.id}"]
      client
        .repos
        .filter { |e| e[:language] == 'JavaScript' }
        .map(&:full_name)
    rescue StandardError
      []
    end
  end
end
