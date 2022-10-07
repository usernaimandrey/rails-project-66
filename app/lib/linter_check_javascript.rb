# frozen_string_literal: true

class LinterCheckJavascript
  class << self
    def check(repo_name)
      repo_path = "#{path}/#{repo_name}"
      command = "node_modules/eslint/bin/eslint.js -c .eslintrc.yml -f json #{repo_path}"
      _stdin, stdout, _stderr, _wait_thr = Open3.popen3(command)
      JSON.parse(stdout.read.delete("\n"))
    end

    def path
      Rails.root.join(DIR_REPO)
    end
  end
end
