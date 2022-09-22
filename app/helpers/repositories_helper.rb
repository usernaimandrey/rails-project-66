# frozen_string_literal: true

module RepositoriesHelper
  def collections_repositories
    client = Octokit::Client.new access_token: current_user&.token, auto_paginate: true
    client
      .repos
      .filter { |e| e[:language] == 'JavaScript' }
      .map(&:full_name)
  rescue StandardError
    []
  end
end
