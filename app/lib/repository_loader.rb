# frozen_string_literal: true

class RepositoryLoader
  class << self
    def git_clone(clone_url, repo_name)
      mkdir
      repo_path = "#{path}/#{repo_name}"
      rm_dir(repo_path)
      _stdin, _stdout, _stderr, _wait_thr = Open3.popen3("git clone #{clone_url} #{repo_path}")
    end

    private

    def path
      Rails.root.join(DIR_REPO)
    end

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
