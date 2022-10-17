# frozen_string_literal: true

module Web
  class Api::ChecksController < Api::ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      repo_name = params['repository']['full_name']
      repo = Repository.find_by(link: repo_name)
      check = repo.checks.build
      check.save!
      CheckLinterService.call(repo, check)
    end
  end
end
