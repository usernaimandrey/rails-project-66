# frozen_string_literal: true

class CheckLinterService
  class << self
    def call(repo, check)
      clone_url = repo.clone_url
      repo_name = repo.repo_name
      ApplicationContainer[:git_clone].git_clone(clone_url, repo_name)
      result = ApplicationContainer[repo.language.downcase.to_sym].check(repo_name)

      if result.empty?
        ActiveRecord::Base.transaction do
          check.update(check_passed: 'true')
          check.finish!
        end
        return
      end

      ActiveRecord::Base.transaction do
        result.each do |data_check|
          file_path = data_check['filePath']
          data_check['messages'].each do |message|
            linter_error = check.linter_error.build(
              file_path: file_path,
              message: message['message'],
              rule: message['ruleId'],
              line_column: "#{message['line']} : #{message['column']}"
            )

            linter_error.save!
          end
        end
        check.finish!
      end
    rescue StandardError
      check.fail!
    end
  end
end
