# frozen_string_literal: true

class RepositoryLoaderStub
  class << self
    def git_clone(_clone_url, _repo_name); end

    private

    def path; end

    def mkdir; end

    def rm_dir(_dir); end

    def rm_config_lint(_repo_path); end
  end
end
