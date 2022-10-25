# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    repo_name = params['repository']['full_name']
    repo = Repository.find_by(full_name: repo_name)
    check = repo&.checks&.build
    if check.save
      CheckLinterJob.perform_later(check.id)
      render json: { status: 200 }
    else
      render json: { status: 422 }
    end
  end
end
