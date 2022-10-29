# frozen_string_literal: true

class RepositoryLoader
  class << self
    def git_clone(clone_url, repo_path)
      rm_dir(repo_path)

      Open3.capture2("git clone #{clone_url} #{repo_path}")
    end

    private

    def rm_dir(dir)
      return unless Dir.exist?(dir)

      FileUtils.rm_r(dir, force: true)
    end
  end
end
