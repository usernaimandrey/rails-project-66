# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM
  extend Enumerize

  validates :passed, presence: true

  enumerize :passed, in: %w[true false], default: 'false'

  belongs_to :repository

  has_many :linter_errors, dependent: :destroy

  aasm do
    state :checking, initial: true
    state :finished
    state :failed

    event :finish do
      transitions from: :checking, to: :finished
    end

    event :fail do
      transitions from: :checking, to: :failed
    end
  end
end
