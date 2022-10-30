# frozen_string_literal: true

class Repository::Check::LinterError < ApplicationRecord
  validates :file_path, presence: true

  belongs_to :check, counter_cache: :count_errors
end
