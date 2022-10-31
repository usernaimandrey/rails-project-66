# frozen_string_literal: true

class LinterCheck
  class << self
    def javascript_check(repo_path)
      conf_path = Rails.root.join('.eslintrc.yml')
      command = "node_modules/eslint/bin/eslint.js -f json -c #{conf_path}  --no-eslintrc #{repo_path}"
      run_check(command)
    end

    def ruby_check(repo_path)
      conf_path = Rails.root.join('config/.rubocop.yml')
      command = "rubocop --format json --config #{conf_path} #{repo_path}"
      run_check(command)
    end

    def run_check(command)
      bash_runner = ApplicationContainer[:bash_runner]
      stdout_str, status = bash_runner.run(command)
      return stdout_str unless bash_runner.success?(status)

      ''
    end
  end
end
