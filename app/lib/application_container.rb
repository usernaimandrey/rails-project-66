# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :repository_loader, -> { RepositoryLoaderStub }
    register :javascript, -> { LinterCheckJavascriptStub }
    register :ruby, -> { LinterCheckRubyStub }
    register :github_api, ->(token) { GithubApiStub.new(token) }
  else
    register :repository_loader, -> { RepositoryLoader }
    register :javascript, -> { LinterCheckJavascript }
    register :ruby, -> { LinterCheckRuby }
    register :github_api, ->(token) { GithubApi.new(token) }
  end
end
