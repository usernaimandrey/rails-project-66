# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :fetch_links, -> { FetchLinksGithubStub }
  else
    register :fetch_links, -> { FetchLinksGithub }
  end
end
