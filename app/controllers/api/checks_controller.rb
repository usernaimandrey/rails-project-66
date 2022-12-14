# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    repo_name = params['repository']['full_name']
    repo = Repository.find_by(full_name: repo_name)
    return unless repo

    check = repo.checks.build
    check.save
    CheckLinterJob.perform_later(check.id)
    render json: { status: 200 }
  end
end
