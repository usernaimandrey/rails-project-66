# frozen_string_literal: true

class CheckLinterService
  extend Deserializer

  class << self
    def call(repo_id, check_id)
      repo = Repository.find_by(id: repo_id)
      check = Repository::Check.find_by(id: check_id)
      clone_url = repo.clone_url
      repo_name = repo.repo_name
      ApplicationContainer[:git_clone].git_clone(clone_url, repo_name)
      result_linter_check = ApplicationContainer[repo.language.downcase.to_sym].check(repo_name)
      last_commit_data = ApplicationContainer[:fetch_last_commit].fetch(repo.user.token, repo.link)

      if result_linter_check.empty?
        ActiveRecord::Base.transaction do
          check.update({ check_passed: 'true' }.merge(last_commit_data))
          check.finish!
        end
        return
      end

      ActiveRecord::Base.transaction do
        send("#{repo.language.downcase}_deserialize", result_linter_check).each do |data_check|
          file_path = data_check[:file_path]
          data_check[:errors].each do |error|
            linter_error = check.linter_error.build(
              file_path: file_path,
              message: error[:message],
              rule: error[:rule],
              line_column: error[:line_column]
            )

            linter_error.save!
          end
        end
        check.finish!
        check.update({ check_passed: 'false' }.merge(last_commit_data))
      end
      repo.user.send_mail(check)
    rescue StandardError
      check.fail!
    end
  end
end
