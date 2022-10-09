# frozen_string_literal: true

class CheckLinterService
  class << self
    def call(repo)
      clone_url = repo.clone_url
      repo_name = repo.repo_name
      ApplicationContainer[:git_clone].git_clone(clone_url, repo_name)
      ApplicationContainer[repo.language.downcase.to_sym].check(repo_name)
    end
  end
end
