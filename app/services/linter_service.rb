# frozen_string_literal: true

class LinterService
  class << self
    def call(check_id)
      check = Repository::Check.find_by(id: check_id)
      return unless check

      check.check!
      repo = check.repository
      clone_url = repo.clone_url
      repo_path = "#{Rails.root.join(DIR_REPO)}/#{repo.name}"

      git_clone(clone_url, repo_path)

      linter_result = LinterCheck.public_send("#{repo.language.downcase}_check", repo_path)

      ActiveRecord::Base.transaction do
        save_errors(repo, linter_result, check)

        check.assign_attributes({ passed: linter_result.empty? }.merge(last_commit_data(repo.user.token, repo.full_name)))
        check.finish!
      end
      send_mail(repo.user, check)
    rescue StandardError
      check.fail!
    end

    def save_errors(repo, linter_result, check)
      Deserializer.public_send("parse_#{repo.language.downcase}", linter_result).each do |data_check|
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

    def last_commit_data(token, full_name)
      ApplicationContainer[:github_api].call(token).fetch_last_commit_ref(full_name)
    end

    def git_clone(clone_url, repo_path)
      bash_runner = ApplicationContainer[:bash_runner]
      bash_runner.run("rm -rf #{repo_path}")

      bash_runner.run("git clone #{clone_url} #{repo_path}")
    end

    def send_mail(user, check)
      return nil if check.passed?

      CheckLinterStatusMailer.with(user: user, check: check).send_mail.deliver_later
    end
  end
  private_class_method :save_errors, :last_commit_data, :git_clone, :send_mail
end
