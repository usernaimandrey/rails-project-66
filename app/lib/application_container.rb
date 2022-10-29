# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :github_api, ->(token) { GithubApiStub.new(token) }
    register :bash_runner, -> { BashRunnerStub }
  else
    register :bash_runner, -> { BashRunner }
    register :github_api, ->(token) { GithubApi.new(token) }
  end
end
