# frozen_string_literal: true

class LinterCheckJavascript
  class << self
    def check(repo_path)
      command = "node_modules/eslint/bin/eslint.js -f json -c #{Rails.root}/.eslintrc.yml --no-eslintrc #{repo_path}"
      stdout_str, status = Open3.capture2(command)
      return stdout_str unless status.to_i.zero?

      ''
    end
  end
end
