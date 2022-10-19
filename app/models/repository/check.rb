# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM
  extend Enumerize

  validates :check_passed, presence: true

  enumerize :check_passed, in: %w[no_check true false], default: 'no_check'

  belongs_to :repository

  has_many :linter_error, dependent: :destroy

  aasm column: :state do
    state :checking, initial: true
    state :finishing
    state :faling

    event :finish do
      transitions from: :checking, to: :finishing
    end

    event :fail do
      transitions from: :checking, to: :faling
    end
  end
end
