# frozen_string_literal: true

class CreateRepositoryJob < ApplicationJob
  queue_as :default

  def perform(repo_id, user_id)
    CreateRepositoryService.call(repo_id, user_id)
  end
end
