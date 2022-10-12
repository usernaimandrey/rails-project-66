# frozen_string_literal: true

class LinterCheckJavascriptStub
  class << self
    def check(repo_name)
      repo_path = "#{path}/#{repo_name}"
      command = "node_modules/eslint/bin/eslint.js -f json #{repo_path}"
      stdout_str, status = Open3.capture2(command)
      return JSON.parse(stdout_str) unless status.to_i.zero?

      []
    end

    def path
      'test/fixtures/files'
    end
  end
end
