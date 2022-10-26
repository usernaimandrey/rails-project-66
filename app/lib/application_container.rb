# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :git_clone, -> { RepositoryLoaderStub }
    register :javascript, -> { LinterCheckJavascriptStub }
    register :ruby, -> { LinterCheckRubyStub }
    register :github_api, -> { GithubApiStub }
  else
    register :git_clone, -> { RepositoryLoader }
    register :javascript, -> { LinterCheckJavascript }
    register :ruby, -> { LinterCheckRuby }
    register :github_api, -> { GithubApi }
  end

  register :octokit, ->(token) { Octokit::Client.new(access_token: token, auto_paginate: true) }
end
