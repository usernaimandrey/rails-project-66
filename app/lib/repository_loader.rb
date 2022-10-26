# frozen_string_literal: true

class RepositoryLoader
  extend DirLoadRepo

  class << self
    def git_clone(clone_url, repo_name)
      mkdir
      repo_path = "#{path}/#{repo_name}"
      rm_dir(repo_path)

      Open3.capture2("git clone #{clone_url} #{repo_path}")
    end

    private

    def mkdir
      return if Dir.exist?(path)

      FileUtils.mkdir(path)
    end

    def rm_dir(dir)
      return unless Dir.exist?(dir)

      FileUtils.rm_r(dir, force: true)
    end
  end
end
