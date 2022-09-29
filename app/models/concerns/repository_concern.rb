# frozen_string_literal: true

module RepositoryConcern
  def collections_repositories_links(user)
    client = Octokit::Client.new access_token: user&.token, auto_paginate: true
    client
      .repos
      .filter { |e| e[:language] == 'JavaScript' }
      .map(&:full_name)
  rescue StandardError
    []
  end
end
