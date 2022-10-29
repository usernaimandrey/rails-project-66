# frozen_string_literal: true

class RepositoryLoader
  class << self
    def git_clone(clone_url, repo_path)
      bash_runner = ApplicationContainer[:bash_runner]
      bash_runner.run("rm -rf #{repo_path}")

      bash_runner.run("git clone #{clone_url} #{repo_path}")
    end
  end
end
