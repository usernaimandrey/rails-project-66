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
          file_path = check.file_paths.build(path: data_check['filePath'])
          data_check['messages'].each do |message|
            file_path.save
            error = file_path.linter_errors.build(
              message: message['message'],
              rule: message['ruleId'],
              line_column: "#{message['line']} : #{message['column']}"
            )
            error.save!
          end
        end
      end
    end
  end
end
