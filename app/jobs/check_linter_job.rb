# frozen_string_literal: true

class CheckLinterJob < ApplicationJob
  queue_as :default

  def perform(repo_id, check_id)
    CheckLinterService.call(repo_id, check_id)
  end
end
