# frozen_string_literal: true

class CheckLinterService
  class << self
    def call(repo, check)
      clone_url = repo.clone_url
      repo_name = repo.repo_name
      ApplicationContainer[:git_clone].git_clone(clone_url, repo_name)
      result = ApplicationContainer[repo.language.downcase.to_sym].check(repo_name)

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
      end
    end
  end
end
