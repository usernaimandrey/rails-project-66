# frozen_string_literal: true

class RepositoryLoaderStub
  class << self
    def git_clone(_clone_url, _repo_name); end
  end
end
