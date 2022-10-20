# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    repo_name = params['repository']['full_name']
    repo = Repository.find_by(full_name: repo_name)
    check = repo.checks.build
    check.save!
    CheckLinterJob.perform_later(repo.id, check.id)
  end
end
