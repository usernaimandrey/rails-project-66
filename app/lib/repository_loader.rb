# frozen_string_literal: true

class RepositoryLoader
  class << self
    def git_clone(clone_url, repo_name)
      mkdir
      repo_path = "#{path}/#{repo_name}"
      rm_dir(repo_path)

      Open3.capture2("git clone #{clone_url} #{repo_path}")

      rm_config_lint(repo_path)
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

    def rm_config_lint(repo_path)
      Dir.entries(repo_path).each do |file|
        delete_list = %w[package.json package-lock.json .eslintrc]
        FileUtils.rm("#{repo_path}/#{file}") if delete_list.include?(file)
      end
    end
  end
end
