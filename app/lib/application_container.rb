# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :fetch_links, -> { FetchLinksGithubStub }
    register :git_clone, -> { RepositoryLoaderStub }
    register :javascript, -> { LinterCheckJavascriptStub }
    register :ruby, -> { LinterCheckRubyStub }
  else
    register :fetch_links, -> { FetchLinksGithub }
    register :git_clone, -> { RepositoryLoader }
    register :javascript, -> { LinterCheckJavascript }
    register :ruby, -> { LinterCheckRuby }
  end

  register :octokit, ->(token) { Octokit::Client.new(access_token: token, auto_paginate: true) }
end
