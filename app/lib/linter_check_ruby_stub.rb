# frozen_string_literal: true

class LinterCheckRubyStub
  class << self
    def check(repo_name)
      repo_path = "#{path}/#{repo_name}"
      conf_path = Rails.root.join('config/.rubocop.yml')
      command = "rubocop --format json --config #{conf_path} #{repo_path}"
      stdout_str, status = Open3.capture2(command)
      return stdout_str unless status.to_i.zero?

      ''
    end

    def path
      'test/fixtures/files'
    end
  end
end
