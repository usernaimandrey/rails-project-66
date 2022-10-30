# frozen_string_literal: true

class CheckLinterJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    LinterService.call(check_id)
  end
end
