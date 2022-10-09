# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  # extend Enumerize

  # validates :check_passed, presence: true

  # enumerize :check_passed, in: %w[true false], default: 'false'
  belongs_to :repository
end
