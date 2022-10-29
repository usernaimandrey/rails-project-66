# frozen_string_literal: true

class CheckLinterService
  extend Deserializer

  class << self
    def call(check_id)
      check = Repository::Check.find_by(id: check_id)
      return unless check

      repo = check.repository
      clone_url = repo.clone_url
      repo_path = "#{Rails.root.join(DIR_REPO)}/#{repo.name}"

      RepositoryLoader.git_clone(clone_url, repo_path)
      last_commit_data = ApplicationContainer[:github_api].call(repo.user.token).fetch_last_commit_ref(repo.full_name)
      check.check!

      result_linter_check = LinterCheck.public_send("#{repo.language.downcase}_check", repo_path)

      ActiveRecord::Base.transaction do
        save_errors(repo, result_linter_check)

        check.assign_attributes({ passed: result_linter_check.empty? }.merge(last_commit_data))
        check.finish!
      end
      CheckLinterStatusMailer.with(user: repo.user, check: check).send_mail.deliver_later
    rescue StandardError
      check.fail!
    end

    private

    def save_errors(repo, result_linter_check)
      public_send("#{repo.language.downcase}_deserialize", result_linter_check).each do |data_check|
        file_path = data_check[:file_path]
        data_check[:errors].each do |error|
          linter_error = check.linter_errors.build(
            file_path: file_path,
            message: error[:message],
            rule: error[:rule],
            line_column: error[:line_column]
          )

          linter_error.save!
        end
      end
    end
  end
end
