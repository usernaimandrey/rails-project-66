# frozen_string_literal: true

class UpdateRepositoryJob < ApplicationJob
  queue_as :default

  def perform(repo_id)
    UpdateRepositoryService.call(repo_id)
  end
end
