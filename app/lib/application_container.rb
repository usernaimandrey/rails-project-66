# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :fetch_links, -> { FetchLinksGithubStub }
    register :git_clone, -> { RepositoryLoaderStub }
    register :javascript, -> { LinterCheckJavascriptStub }
  else
    register :fetch_links, -> { FetchLinksGithub }
    register :git_clone, -> { RepositoryLoader }
    register :javascript, -> { LinterCheckJavascript }
  end
end
