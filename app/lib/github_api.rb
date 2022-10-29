# frozen_string_literal: true

class GithubApi
  def initialize(token)
    @client = Octokit::Client.new(access_token: token, auto_paginate: true)
  end

  def fetch_repo(github_id)
    @client.repo(github_id)
  end

  def setup_hook(github_id)
    url = Rails.application.routes.url_helpers.api_checks_url
    @client.hooks(github_id).each do |hook|
      if hook[:config][:url] == url
        @client.remove_hook(github_id, hook[:id])
      end
    end

    @client.create_hook(
      github_id,
      'web',
      { url: url, content_type: 'json' },
      { events: %w[push], active: true }
    )
  end

  def fetch_links_github
    language = Repository.language.values
    @client
      .repos
      .filter { |repo| language.include?(repo[:language]&.downcase) }
      .map { |repo| [repo[:full_name], repo[:id]] }
  rescue StandardError
    []
  end

  def fetch_last_commit_ref(full_name)
    response = @client.commits(full_name).first
    { last_commit_sha: response[:sha][0..6], last_commit_url: response[:html_url] }
  end
end
