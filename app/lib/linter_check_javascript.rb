# frozen_string_literal: true

class LinterCheckJavascript
  class << self
    def check(repo_name)
      repo_path = "#{path}/#{repo_name}"
      command = "node_modules/eslint/bin/eslint.js -f json #{repo_path}"
      stdout_str, _status = Open3.capture2(command)
      return JSON.parse(stdout_str) unless stdout_str.empty?

      []
    end

    def path
      Rails.root.join(DIR_REPO)
    end
  end
end
